import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

/// Maps Dio exceptions to app-specific exceptions.
class NetworkExceptions {
  NetworkExceptions._();

  static ServerException fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerException(
          message: 'Connection timed out',
          statusCode: 408,
        );
      case DioExceptionType.connectionError:
        throw const NetworkException();
      case DioExceptionType.badResponse:
        return ServerException(
          message: exception.error?.toString() ?? 'Server error',
          statusCode: exception.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return const ServerException(
          message: 'Request cancelled',
        );
      default:
        return ServerException(
          message: exception.error?.toString() ?? 'Unexpected error',
        );
    }
  }
}
