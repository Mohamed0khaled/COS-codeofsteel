import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/user_profile/domain/repositories/user_profile_repository.dart';

/// Use case to create initial user profile after registration
class CreateUserProfileUseCase implements UseCase<Unit, CreateUserProfileParams> {
  final UserProfileRepository repository;

  CreateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CreateUserProfileParams params) {
    return repository.createUserProfile(
      userId: params.userId,
      username: params.username,
      photoUrl: params.photoUrl,
    );
  }
}

class CreateUserProfileParams extends Equatable {
  final String userId;
  final String username;
  final String? photoUrl;

  const CreateUserProfileParams({
    required this.userId,
    required this.username,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [userId, username, photoUrl];
}
