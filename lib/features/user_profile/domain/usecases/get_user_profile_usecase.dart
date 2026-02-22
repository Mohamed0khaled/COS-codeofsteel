import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:coursesapp/features/user_profile/domain/repositories/user_profile_repository.dart';

/// Use case to get the complete user profile.
class GetUserProfileUseCase implements UseCase<UserProfileEntity, GetUserProfileParams> {
  final UserProfileRepository _repository;

  GetUserProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(GetUserProfileParams params) {
    return _repository.getUserProfile(params.userId);
  }
}

/// Parameters for GetUserProfileUseCase.
class GetUserProfileParams extends Equatable {
  final String userId;

  const GetUserProfileParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
