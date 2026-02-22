/// Base class for all exceptions in the application.
/// Exceptions are thrown for unexpected errors that break normal flow.
class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Exception when there's no internet connection
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.code,
  });
}

/// Exception when Firebase operations fail
class FirebaseException extends AppException {
  const FirebaseException({
    required super.message,
    super.code,
  });
}

/// Exception when authentication fails
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
  });
}

/// Exception when server returns an error
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    super.message = 'Server error',
    this.statusCode,
    super.code,
  });
}

/// Exception for cache/local storage operations
class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache error',
    super.code,
  });
}

/// Exception when requested data is not found
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Requested data not found',
    super.code,
  });
}
