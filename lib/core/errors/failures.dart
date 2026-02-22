import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
/// 
/// Failures represent expected errors that can be handled gracefully.
/// Always use named parameters when creating failures:
/// 
/// ```dart
/// return Left(ServerFailure(message: 'Custom error message'));
/// return Left(NetworkFailure()); // Uses default message
/// ```
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Failure when there's no internet connection.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
    super.code,
  });
}

/// Failure when Firebase operations fail.
class FirebaseFailure extends Failure {
  const FirebaseFailure({
    required super.message,
    super.code,
  });
}

/// Failure when authentication fails.
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

/// Failure when server returns an error.
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error occurred. Please try again later.',
    super.code,
  });
}

/// Failure for cache/local storage operations.
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to access local storage.',
    super.code,
  });
}

/// Failure for invalid input data.
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

/// Generic unexpected failure.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred.',
    super.code,
  });
}
