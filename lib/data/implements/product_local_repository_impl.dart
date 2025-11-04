// lib/data/repositories/product_local_repository_impl.dart
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/data/local/product_local_data_source.dart';
import 'package:stockly/data/repository/product_local_repository.dart';

class ProductLocalRepositoryImpl implements ProductLocalRepository {
  final ProductLocalDataSource localDataSource;

  ProductLocalRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveProduct(Product product) async {
    await localDataSource.saveProduct(product);
  }

  @override
  List<Product> getAllProducts() {
    return localDataSource.getAllProducts();
  }

  @override
  Product? getProductById(int id) {
    return localDataSource.getProductById(id);
  }

  @override
  Future<void> deleteProduct(int id) async {
    await localDataSource.deleteProduct(id);
  }

  @override
  Future<void> clearAll() async {
    await localDataSource.clearAll();
  }
}
