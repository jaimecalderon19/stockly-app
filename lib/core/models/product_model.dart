// lib/core/models/product_model.dart
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final String category;

  // Nombre personalizado para el producto (solo local)
  @HiveField(6)
  String? customName;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    this.customName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        image: json['image'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        category: json['category'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'price': price,
        'category': category,
        'customName': customName,
      };
}
