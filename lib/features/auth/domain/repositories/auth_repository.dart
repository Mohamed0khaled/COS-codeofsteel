import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';

/// Abstract repository interface for authentication operations.
/// 
/// This defines the contract that any auth repository implementation
/// must follow. The domain layer only knows about this interface,
/// not the concrete implementation.
abstract class AuthRepository {
  /// Sign in with email and password
  /// 
  /// Returns [UserEntity] on success or [Failure] on error.
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Register a new user with email, password, and optional username
  /// 
  /// Returns [UserEntity] on success or [Failure] on error.
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    String? username,
  });

  /// Sign in with Google
  /// 
  /// Returns [UserEntity] on success or [Failure] on error.
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Get the currently authenticated user
  /// 
  /// Returns [UserEntity] if user is logged in, or [Failure] if not.
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Sign out the current user
  /// 
  /// Returns [void] on success or [Failure] on error.
  Future<Either<Failure, void>> logout();

  /// Send email verification to the current user
  /// 
  /// Returns [void] on success or [Failure] on error.
  Future<Either<Failure, void>> sendEmailVerification();

  /// Reload user data from Firebase
  /// 
  /// Returns [UserEntity] with updated data or [Failure] on error.
  Future<Either<Failure, UserEntity>> reloadUser();

  /// Stream of auth state changes
  /// 
  /// Emits [UserEntity] when user signs in, null when signs out.
  Stream<UserEntity?> get authStateChanges;
}
