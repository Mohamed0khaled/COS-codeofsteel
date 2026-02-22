import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/course_repository.dart';

/// Use case to check if a user owns a course.
class CheckCourseOwnership implements UseCase<bool, CheckCourseOwnershipParams> {
  final CourseRepository _repository;

  CheckCourseOwnership(this._repository);

  @override
  Future<Either<Failure, bool>> call(CheckCourseOwnershipParams params) {
    return _repository.isCourseOwned(params.userId, params.courseId);
  }
}

class CheckCourseOwnershipParams extends Equatable {
  final String userId;
  final int courseId;

  const CheckCourseOwnershipParams({
    required this.userId,
    required this.courseId,
  });

  @override
  List<Object?> get props => [userId, courseId];
}
