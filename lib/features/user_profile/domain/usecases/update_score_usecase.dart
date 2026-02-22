import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:coursesapp/features/user_profile/domain/repositories/user_profile_repository.dart';

/// Use case to update the user score
/// 
/// This also recalculates and updates rank and level
class UpdateScoreUseCase implements UseCase<UserProfileEntity, UpdateScoreParams> {
  final UserProfileRepository repository;

  UpdateScoreUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(UpdateScoreParams params) {
    return repository.updateScore(
      userId: params.userId,
      newScore: params.newScore,
    );
  }
}

class UpdateScoreParams extends Equatable {
  final String userId;
  final int newScore;

  const UpdateScoreParams({
    required this.userId,
    required this.newScore,
  });

  @override
  List<Object?> get props => [userId, newScore];
}
