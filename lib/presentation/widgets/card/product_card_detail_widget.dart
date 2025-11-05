import 'package:flutter/material.dart';

class ProductCardDetailWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final double price;
  final double rating;
  final int reviewsCount;
  final String description;
  final VoidCallback? onDelete;

  const ProductCardDetailWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del producto
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),

          // Nombre
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),

          // Categoría
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Precio y valoración
          Row(
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4B3FF9),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.star, size: 18, color: Colors.amber),
              const SizedBox(width: 2),
              Text(
                rating.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                ' ($reviewsCount opiniones)',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Descripción
          const Text(
            'Descripción',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Botón eliminar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              label: const Text(
                'Eliminar producto',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
