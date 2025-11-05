import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/logic/prefs_cubit/preference_cubit.dart';
import 'package:stockly/logic/prefs_cubit/preference_state.dart';
import 'package:stockly/presentation/widgets/card/product_card_detail_widget.dart';
import 'package:stockly/presentation/widgets/header_title_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/prefs/detail';

  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int? productId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Recibir argumento desde la ruta
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null && args['product_id'] != null) {
      productId = args['product_id'] as int;
    }

    // Cargar productos locales (en caso de no estar actualizados)
    context.read<PreferenceCubit>().loadSavedProducts();
  }

  void _handleDelete(Product product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text(
          '¿Seguro que deseas eliminar "${product.customName ?? product.title}"?',
        ),
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto eliminado')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderTitle(text: "Detalle del producto"),
      ),
      body: BlocBuilder<PreferenceCubit, PreferenceState>(
        builder: (context, state) {
          if (state is PreferenceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PreferenceError) {
            return Center(child: Text(state.message));
          } else if (state is PreferenceSuccess) {
            final product = state.savedProducts
                .firstWhere((p) => p.id == productId, orElse: () => Product(
                      id: 0,
                      title: '',
                      description: '',
                      image: '',
                      price: 0,
                      category: '',
                    ));

            if (product.id == 0) {
              return const Center(child: Text('Producto no encontrado.'));
            }

            // Calcular datos ficticios de reseñas (Fake Store no tiene estos campos)
            final fakeRating = (product.price / 10).clamp(1.0, 5.0);
            final fakeReviews = (product.price * 7).toInt();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ProductCardDetailWidget(
                imageUrl: product.image,
                title: product.customName ?? product.title,
                category: product.category,
                price: product.price,
                rating: fakeRating,
                reviewsCount: fakeReviews,
                description: product.description,
                onDelete: () => _handleDelete(product),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
