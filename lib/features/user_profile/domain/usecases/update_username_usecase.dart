import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/user_profile/domain/repositories/user_profile_repository.dart';

/// Use case to update the username.
class UpdateUsernameUseCase implements UseCase<Unit, UpdateUsernameParams> {
  final UserProfileRepository _repository;

  UpdateUsernameUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateUsernameParams params) {
    return _repository.updateUsername(
      userId: params.userId,
      newUsername: params.newUsername,
    );
  }
}

/// Parameters for UpdateUsernameUseCase.
class UpdateUsernameParams extends Equatable {
  final String userId;
  final String newUsername;

  const UpdateUsernameParams({
    required this.userId,
    required this.newUsername,
  });

  @override
  List<Object?> get props => [userId, newUsername];
}
