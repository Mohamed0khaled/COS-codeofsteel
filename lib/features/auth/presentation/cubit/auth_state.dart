import 'package:equatable/equatable.dart';
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';

/// Base state for Auth Cubit.
/// 
/// All auth states extend this class for type safety.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app starts.
/// Auth status is unknown.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state during authentication operations.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated.
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// User is not authenticated.
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Authentication error occurred.
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Email verification sent successfully.
class AuthEmailVerificationSent extends AuthState {
  const AuthEmailVerificationSent();
}

/// Registration successful - may need email verification.
class AuthRegistered extends AuthState {
  final UserEntity user;

  const AuthRegistered(this.user);

  @override
  List<Object?> get props => [user];
}
