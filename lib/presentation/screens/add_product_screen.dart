import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/logic/api_cubit/api_cubit.dart';
import 'package:stockly/logic/api_cubit/api_state.dart';
import 'package:stockly/logic/prefs_cubit/preference_cubit.dart';
import 'package:stockly/logic/prefs_cubit/preference_state.dart';
import 'package:stockly/presentation/widgets/button_custom_widget.dart';
import 'package:stockly/presentation/widgets/card/product_card_widget.dart';
import 'package:stockly/presentation/widgets/header_title_widget.dart';
import 'package:stockly/presentation/widgets/sheet/show_dropdown.dart';
import 'package:stockly/presentation/widgets/text_field_custom_widget.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/prefs/new';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Product? _selectedProduct;
  final TextEditingController _nameController = TextEditingController();

  int? _productIdFromArgs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recibir argumentos desde la ruta
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null && args['product_id'] != null) {
      _productIdFromArgs = args['product_id'] as int;
    }

    // Si no se ha cargado nada aún, pedimos los productos
    context.read<ApiCubit>().fetchProducts();
  }

  void _trySelectProduct(List<Product> products) {
    if (_productIdFromArgs != null && _selectedProduct == null) {
      final product = products.firstWhere(
        (p) => p.id == _productIdFromArgs,
        orElse: () => products.first,
      );

      // Esperar hasta que el build termine antes de hacer setState
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedProduct = product;
          });
        }
      });
    }
  }


  void _saveProduct() async {
    if (_selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un producto')),
      );
      return;
    }

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un nombre personalizado')),
      );
      return;
    }

    final productToSave = Product(
      id: _selectedProduct!.id,
      title: _selectedProduct!.title,
      description: _selectedProduct!.description,
      image: _selectedProduct!.image,
      price: _selectedProduct!.price,
      category: _selectedProduct!.category,
      customName: _nameController.text.trim(),
    );

    await context.read<PreferenceCubit>().saveProduct(productToSave);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto guardado exitosamente')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderTitle(text: "Guardar producto")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 🔽 Selector de producto (vía Cubit)
            BlocBuilder<ApiCubit, ApiState>(
              builder: (context, state) {
                if (state is ApiLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ApiError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(state.message),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<ApiCubit>().fetchProducts(),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                } else if (state is ApiSuccess) {
                  final products = state.products;

                  // Si hay argumento, seleccionamos el producto automáticamente
                  _trySelectProduct(products);

                  return CustomTextField(
                      icon: const Icon(HugeIcons.strokeRoundedArrowDown01),
                      label: 'Selecciona un producto',
                      placeholder: _selectedProduct?.title ?? 'Selecciona un producto',
                      inputType: TextInputType.text,
                      isRequired: true,
                      controller: TextEditingController(),
                      onTap: () {
                        showDialogOptions(context, products.map((product) {return {'label': product.title, 'value': product.id};}).toList(), (value) {
                          setState(() {
                            _selectedProduct = products.firstWhere((product) => product.id == value['value']);
                          });
                        });
                      },
                    );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _nameController,
              label: 'Nombre personalizado',
              placeholder: 'Nombre personalizado',
              inputType: TextInputType.text,
              isRequired: true,
            ),
            const SizedBox(height: 10),
            if (_selectedProduct != null)...[
              const Text(
                "Vista previa del producto",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:FontWeight.w500)
              ,),
              ProductCardWidget(
                imageUrl: _selectedProduct!.image,
                title: _selectedProduct!.title,
                category: _selectedProduct!.category, 
                price: _selectedProduct!.price
              ),
            ],
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: ButtonCustom(
                  isOutline: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancelar',
                ),),
                const SizedBox(width: 8),
                Expanded(
                  child: BlocBuilder<PreferenceCubit, PreferenceState>(
                  builder: (context, state) {
                    final isLoading = state is PreferenceLoading;
                    return  ButtonCustom(
                        isLoading: isLoading,
                        onPressed: _saveProduct,
                        text: 'Guardar',
                    );
                  },
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}