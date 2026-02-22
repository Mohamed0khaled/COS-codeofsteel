import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/user_profile/domain/repositories/user_profile_repository.dart';

/// Use case to update the profile image URL.
class UpdateProfileImageUseCase implements UseCase<Unit, UpdateProfileImageParams> {
  final UserProfileRepository _repository;

  UpdateProfileImageUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateProfileImageParams params) {
    return _repository.updateProfileImage(
      userId: params.userId,
      imageUrl: params.imageUrl,
    );
  }
}

/// Parameters for UpdateProfileImageUseCase.
class UpdateProfileImageParams extends Equatable {
  final String userId;
  final String imageUrl;

  const UpdateProfileImageParams({
    required this.userId,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [userId, imageUrl];
}
