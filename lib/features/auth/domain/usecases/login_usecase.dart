import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';
import 'package:coursesapp/features/auth/domain/repositories/auth_repository.dart';

/// Use case for user login with email and password.
class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for login use case.
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
