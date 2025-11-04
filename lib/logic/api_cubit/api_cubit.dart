import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockly/data/repository/product_repository.dart';
import 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final ProductRepository repository;

  ApiCubit(this.repository) : super(ApiInitial());

  /// Obtiene todos los productos desde la API
  Future<void> fetchProducts() async {
    emit(ApiLoading());
    try {
      final products = await repository.fetchAllProducts();
      emit(ApiSuccess(products));
    } catch (e) {
      emit(ApiError('Error al obtener los productos: $e'));
    }
  }

  /// Busca productos por categoría
  Future<void> fetchByCategory(String category) async {
    emit(ApiLoading());
    try {
      final products = await repository.fetchProductsByCategory(category);
      emit(ApiSuccess(products));
    } catch (e) {
      emit(ApiError('Error al filtrar productos: $e'));
    }
  }

  /// Obtiene un producto por su ID
  Future<void> fetchProductById(int id) async {
    emit(ApiLoading());
    try {
      final product = await repository.fetchProductById(id);
      emit(ApiSuccess([product]));
    } catch (e) {
      emit(ApiError('Error al obtener el producto: $e'));
    }
  }
}
