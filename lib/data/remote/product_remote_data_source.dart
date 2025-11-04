// lib/data/remote/product_remote_data_source.dart
import 'package:stockly/core/api_client.dart';
import 'package:stockly/core/models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSource(this.apiClient);

  /// Obtiene todos los productos desde la Fake Store API
  Future<List<Product>> getAllProducts() async {
    final data = await apiClient.get('/products');

    if (data is List) {
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Respuesta inválida del servidor');
    }
  }

  /// Obtiene un producto por ID
  Future<Product> getProductById(int id) async {
    final data = await apiClient.get('/products/$id');
    return Product.fromJson(data);
  }

  /// Busca productos por categoría
  Future<List<Product>> getProductsByCategory(String category) async {
    final data = await apiClient.get('/products/category/$category');

    if (data is List) {
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Respuesta inválida al buscar por categoría');
    }
  }
}
