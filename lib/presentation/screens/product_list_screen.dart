import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/logic/api_cubit/api_cubit.dart';
import 'package:stockly/logic/api_cubit/api_state.dart';
import 'package:stockly/presentation/screens/add_product_screen.dart';
import 'package:stockly/presentation/widgets/card/product_card_widget.dart';
import 'package:stockly/presentation/widgets/header_title_widget.dart';
import 'package:stockly/presentation/widgets/text_field_custom_widget.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/api-list';
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    // Cargar productos al iniciar
    context.read<ApiCubit>().fetchProducts();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() => _filteredProducts = _allProducts);
    } else {
      final results = _allProducts
          .where((p) =>
              p.title.toLowerCase().contains(query.toLowerCase()) ||
              p.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() => _filteredProducts = results);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderTitle(text: "Productos disponibles"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ApiCubit>().fetchProducts();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: Column(
          children: [
            // Campo de búsqueda
            CustomTextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              label: '',
              placeholder: 'Buscar producto...',
              inputType: TextInputType.text,
              isRequired: true,
            ),
            const SizedBox(height: 10),

            // Contenido dinámico según estado del Cubit
            Expanded(
              child: BlocBuilder<ApiCubit, ApiState>(
                builder: (context, state) {
                  if (state is ApiLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ApiError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                    _allProducts = state.products;
                    if (_filteredProducts.isEmpty &&
                        _searchController.text.isEmpty) {
                      _filteredProducts = _allProducts;
                    }

                    if (_filteredProducts.isEmpty) {
                      return const Center(
                        child: Text('No se encontraron productos.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return ProductCardWidget(
                          category: product.category,
                          imageUrl: product.image,
                          price: product.price,
                          title: product.title, 
                          onTap: () {
                            Navigator.pushNamed(context, AddProductScreen.routeName, arguments: {'product_id': product.id});
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
