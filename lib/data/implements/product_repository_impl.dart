// lib/data/repositories/product_repository_impl.dart
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/data/remote/product_remote_data_source.dart';
import 'package:stockly/data/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> fetchAllProducts() async {
    try {
      return await remoteDataSource.getAllProducts();
    } catch (e) {
      throw Exception('Error al obtener productos: $e');
    }
  }

  @override
  Future<Product> fetchProductById(int id) async {
    try {
      return await remoteDataSource.getProductById(id);
    } catch (e) {
      throw Exception('Error al obtener el producto $id: $e');
    }
  }

  @override
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      return await remoteDataSource.getProductsByCategory(category);
    } catch (e) {
      throw Exception('Error al filtrar productos: $e');
    }
  }
}
