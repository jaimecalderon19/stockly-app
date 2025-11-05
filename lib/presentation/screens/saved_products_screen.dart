import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/logic/prefs_cubit/preference_cubit.dart';
import 'package:stockly/logic/prefs_cubit/preference_state.dart';
import 'package:stockly/presentation/screens/add_product_screen.dart';
import 'package:stockly/presentation/screens/product_detail_screen.dart';
import 'package:stockly/presentation/widgets/card/product_card_widget.dart';
import 'package:stockly/presentation/widgets/header_title_widget.dart';

class SavedProductsScreen extends StatefulWidget {
  static const String routeName = '/prefs';

  const SavedProductsScreen({super.key});

  @override
  State<SavedProductsScreen> createState() => _SavedProductsScreenState();
}

class _SavedProductsScreenState extends State<SavedProductsScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar productos guardados al entrar
    context.read<PreferenceCubit>().loadSavedProducts();
  }

  void _deleteProduct(Product product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Seguro que deseas eliminar "${product.customName ?? product.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await context.read<PreferenceCubit>().deleteProduct(product.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto eliminado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderTitle(text: "Mis productos guardados")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PreferenceCubit, PreferenceState>(
          builder: (context, state) {
            if (state is PreferenceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PreferenceError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => context.read<PreferenceCubit>().loadSavedProducts(),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            } else if (state is PreferenceSuccess) {
              final products = state.savedProducts;

              if (products.isEmpty) {
                return const Center(
                  child: Text(
                    'Aún no tienes productos guardados',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PreferenceCubit>().loadSavedProducts();
                },
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ProductCardWidget(
                      imageUrl: product.image,
                      title: product.customName ?? product.title,
                      category: product.category,
                      price: product.price,
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: {'product_id': product.id});
                      },
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),

      // Botón para agregar nuevo producto
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AddProductScreen.routeName),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo producto'),
      ),
    );
  }
}
