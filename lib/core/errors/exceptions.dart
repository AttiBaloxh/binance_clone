/// Data-layer exceptions that get caught and mapped to [Failure] types.
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() =>
      'ServerException(message: $message, statusCode: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Cache operation failed'});

  @override
  String toString() => 'CacheException(message: $message)';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({
    this.message = 'No internet connection',
  });

  @override
  String toString() => 'NetworkException(message: $message)';
}

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  const AuthException({required this.message, this.statusCode});

  @override
  String toString() =>
      'AuthException(message: $message, statusCode: $statusCode)';
}

class UnexpectedException implements Exception {
  final String message;

  const UnexpectedException({
    this.message = 'An unexpected error occurred',
  });

  @override
  String toString() => 'UnexpectedException(message: $message)';
}
