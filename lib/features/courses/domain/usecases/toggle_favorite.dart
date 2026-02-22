import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/course_repository.dart';

/// Use case to toggle favorite status of a course.
class ToggleFavorite implements UseCase<void, ToggleFavoriteParams> {
  final CourseRepository _repository;

  ToggleFavorite(this._repository);

  @override
  Future<Either<Failure, void>> call(ToggleFavoriteParams params) {
    return _repository.updateFavorite(
      params.userId,
      params.courseId,
      params.favorite,
    );
  }
}

class ToggleFavoriteParams extends Equatable {
  final String userId;
  final int courseId;
  final bool favorite;

  const ToggleFavoriteParams({
    required this.userId,
    required this.courseId,
    required this.favorite,
  });

  @override
  List<Object?> get props => [userId, courseId, favorite];
}
