import 'package:dio/dio.dart';

/// ApiClient - Servicio centralizado para consumo de la Fake Store API.
/// Permite realizar peticiones HTTP de forma segura y reutilizable.
///
/// Ejemplo de uso:
/// ```dart
/// final api = ApiClient();
/// final products = await api.get('/products');
/// ```
class ApiClient {
  late final Dio _dio;

  static const String baseUrl = 'https://fakestoreapi.com';

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Agregar interceptores opcionales (logs, errores, etc.)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[REQUEST] ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('[RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('[ERROR] ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  /// Método genérico GET
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// Método genérico POST
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// Método genérico PUT
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// Método genérico DELETE
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// Manejador de errores centralizado
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tiempo de conexión agotado.';
      case DioExceptionType.sendTimeout:
        return 'Error al enviar la solicitud.';
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de espera de respuesta agotado.';
      case DioExceptionType.badResponse:
        return 'Error del servidor (${error.response?.statusCode}).';
      case DioExceptionType.cancel:
        return 'Solicitud cancelada.';
      default:
        return 'Error inesperado: ${error.message}';
    }
  }
}
