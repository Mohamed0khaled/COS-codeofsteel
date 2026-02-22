import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/auth/domain/usecases/login_usecase.dart';
import 'package:coursesapp/features/auth/domain/usecases/register_usecase.dart';
import 'package:coursesapp/features/auth/domain/usecases/logout_usecase.dart';
import 'package:coursesapp/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:coursesapp/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:coursesapp/features/auth/presentation/cubit/auth_state.dart';

/// Auth Cubit handles all authentication state management.
/// 
/// This Cubit does NOT replace existing GetX controllers.
/// It's prepared for future migration when screens are ready to use it.
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _signInWithGoogleUseCase = signInWithGoogleUseCase,
        super(const AuthInitial());

  /// Check if user is already authenticated.
  Future<void> checkAuthStatus() async {
    emit(const AuthLoading());

    final result = await _getCurrentUserUseCase(NoParams());

    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Login with email and password.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Register with email, password, and optional username.
  Future<void> register({
    required String email,
    required String password,
    String? username,
  }) async {
    emit(const AuthLoading());

    final result = await _registerUseCase(
      RegisterParams(
        email: email,
        password: password,
        username: username,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthRegistered(user)),
    );
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());

    final result = await _signInWithGoogleUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Logout current user.
  Future<void> logout() async {
    emit(const AuthLoading());

    final result = await _logoutUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  /// Clear error state and return to initial.
  void clearError() {
    emit(const AuthUnauthenticated());
  }
}
