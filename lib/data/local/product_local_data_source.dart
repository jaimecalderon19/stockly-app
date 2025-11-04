// lib/data/local/product_local_data_source.dart
import 'package:hive/hive.dart';
import 'package:stockly/core/models/product_model.dart';

class ProductLocalDataSource {
  static const String boxName = 'products_box';

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductAdapter());
    }
    await Hive.openBox<Product>(boxName);
  }

  Box<Product> get _box => Hive.box<Product>(boxName);

  /// Crear o actualizar producto
  Future<void> saveProduct(Product product) async {
    await _box.put(product.id, product);
  }

  /// Obtener todos los productos guardados
  List<Product> getAllProducts() {
    return _box.values.toList();
  }

  /// Obtener producto por ID
  Product? getProductById(int id) {
    return _box.get(id);
  }

  /// Eliminar producto por ID
  Future<void> deleteProduct(int id) async {
    await _box.delete(id);
  }

  /// Limpiar todos los productos guardados
  Future<void> clearAll() async {
    await _box.clear();
  }
}
