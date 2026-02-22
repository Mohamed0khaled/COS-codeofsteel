import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';
import 'package:coursesapp/features/auth/domain/repositories/auth_repository.dart';

/// Use case for Google Sign-In.
class SignInWithGoogleUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}
