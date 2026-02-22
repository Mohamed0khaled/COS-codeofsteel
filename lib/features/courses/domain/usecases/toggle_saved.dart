import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/course_repository.dart';

/// Use case to toggle saved status of a course.
class ToggleSaved implements UseCase<void, ToggleSavedParams> {
  final CourseRepository _repository;

  ToggleSaved(this._repository);

  @override
  Future<Either<Failure, void>> call(ToggleSavedParams params) {
    return _repository.updateSaved(
      params.userId,
      params.courseId,
      params.saved,
    );
  }
}

class ToggleSavedParams extends Equatable {
  final String userId;
  final int courseId;
  final bool saved;

  const ToggleSavedParams({
    required this.userId,
    required this.courseId,
    required this.saved,
  });

  @override
  List<Object?> get props => [userId, courseId, saved];
}
