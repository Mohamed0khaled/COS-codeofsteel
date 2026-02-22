import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';
import 'package:coursesapp/features/auth/domain/repositories/auth_repository.dart';

/// Use case for user registration with email and password.
class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await _repository.register(
      email: params.email,
      password: params.password,
      username: params.username,
    );
  }
}

/// Parameters for register use case.
class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String? username;

  const RegisterParams({
    required this.email,
    required this.password,
    this.username,
  });

  @override
  List<Object?> get props => [email, password, username];
}
