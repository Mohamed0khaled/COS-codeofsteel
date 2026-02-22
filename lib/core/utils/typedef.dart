import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';

/// Common type definitions used throughout the application.

/// Represents the result of an operation that can either fail or succeed.
/// Left = Failure, Right = Success
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Represents a synchronous result that can either fail or succeed.
typedef ResultSync<T> = Either<Failure, T>;

/// Represents a void result that can either fail or succeed.
typedef ResultVoid = ResultFuture<void>;

/// Type alias for JSON data
typedef DataMap = Map<String, dynamic>;
