import 'package:dio/dio.dart';

/// API interceptor for token injection, error mapping, and request logging.
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // In production, inject auth token from secure storage here:
    // final token = await SecureStorageService.getToken();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Map Dio errors to app-specific error messages
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: 'Connection timed out. Please try again.',
            type: err.type,
          ),
        );
        break;
      case DioExceptionType.connectionError:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: 'No internet connection.',
            type: err.type,
          ),
        );
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        String message;
        if (statusCode == 401) {
          message = 'Unauthorized. Please log in again.';
          // In production: trigger token refresh or force logout
        } else if (statusCode == 403) {
          message = 'Access denied.';
        } else if (statusCode == 404) {
          message = 'Resource not found.';
        } else if (statusCode == 429) {
          message = 'Too many requests. Please wait a moment.';
        } else if (statusCode != null && statusCode >= 500) {
          message = 'Server error. Please try again later.';
        } else {
          message = err.response?.data?['msg'] ?? 'Something went wrong.';
        }
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            error: message,
            type: err.type,
          ),
        );
        break;
      default:
        handler.next(err);
    }
  }
}
