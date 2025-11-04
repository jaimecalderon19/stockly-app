import 'package:stockly/core/models/product_model.dart';

abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiSuccess extends ApiState {
  final List<Product> products;
  ApiSuccess(this.products);
}

class ApiError extends ApiState {
  final String message;
  ApiError(this.message);
}
