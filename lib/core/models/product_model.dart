// lib/core/models/product_model.dart

class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'price': price,
        'category': category,
      };
}
