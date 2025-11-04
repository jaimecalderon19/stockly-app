// lib/logic/cubits/prefs_cubit/preference_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/data/repository/product_local_repository.dart';
import 'preference_state.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  final ProductLocalRepository localRepository;

  PreferenceCubit(this.localRepository) : super(PreferenceInitial());

  /// Obtiene todos los productos guardados localmente
  void loadSavedProducts() {
    emit(PreferenceLoading());
    try {
      final products = localRepository.getAllProducts();
      emit(PreferenceSuccess(products));
    } catch (e) {
      emit(PreferenceError('Error al cargar los productos: $e'));
    }
  }

  /// Guarda un nuevo producto o lo actualiza
  Future<void> saveProduct(Product product) async {
    emit(PreferenceLoading());
    try {
      await localRepository.saveProduct(product);
      loadSavedProducts(); // refresca lista
    } catch (e) {
      emit(PreferenceError('Error al guardar el producto: $e'));
    }
  }

  /// Elimina un producto guardado
  Future<void> deleteProduct(int id) async {
    emit(PreferenceLoading());
    try {
      await localRepository.deleteProduct(id);
      loadSavedProducts();
    } catch (e) {
      emit(PreferenceError('Error al eliminar el producto: $e'));
    }
  }

  /// Limpia toda la base local
  Future<void> clearAll() async {
    emit(PreferenceLoading());
    try {
      await localRepository.clearAll();
      emit(PreferenceSuccess([]));
    } catch (e) {
      emit(PreferenceError('Error al limpiar los productos: $e'));
    }
  }
}
