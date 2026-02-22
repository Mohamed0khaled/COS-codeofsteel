import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';
import 'package:coursesapp/features/auth/domain/repositories/auth_repository.dart';

/// Use case to get the currently authenticated user.
class GetCurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _repository.getCurrentUser();
  }
}
