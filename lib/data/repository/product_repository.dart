import 'package:stockly/core/models/product_model.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchAllProducts();
  Future<Product> fetchProductById(int id);
  Future<List<Product>> fetchProductsByCategory(String category);
}
