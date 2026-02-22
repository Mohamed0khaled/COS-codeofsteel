import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/course_repository.dart';

/// Use case to update progress of a course.
class UpdateCourseProgress implements UseCase<void, UpdateCourseProgressParams> {
  final CourseRepository _repository;

  UpdateCourseProgress(this._repository);

  @override
  Future<Either<Failure, void>> call(UpdateCourseProgressParams params) {
    return _repository.updateProgress(
      params.userId,
      params.courseId,
      params.progress,
    );
  }
}

class UpdateCourseProgressParams extends Equatable {
  final String userId;
  final int courseId;
  final int progress;

  const UpdateCourseProgressParams({
    required this.userId,
    required this.courseId,
    required this.progress,
  });

  @override
  List<Object?> get props => [userId, courseId, progress];
}
