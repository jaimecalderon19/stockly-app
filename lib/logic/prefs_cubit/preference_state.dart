// lib/logic/cubits/prefs_cubit/preference_state.dart
import 'package:stockly/core/models/product_model.dart';

abstract class PreferenceState {}

class PreferenceInitial extends PreferenceState {}

class PreferenceLoading extends PreferenceState {}

class PreferenceSuccess extends PreferenceState {
  final List<Product> savedProducts;
  PreferenceSuccess(this.savedProducts);
}

class PreferenceError extends PreferenceState {
  final String message;
  PreferenceError(this.message);
}
