import 'package:stockly/core/models/product_model.dart';

abstract class ProductLocalRepository {
  Future<void> saveProduct(Product product);
  List<Product> getAllProducts();
  Product? getProductById(int id);
  Future<void> deleteProduct(int id);
  Future<void> clearAll();
}