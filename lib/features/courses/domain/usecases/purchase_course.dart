import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/course_repository.dart';

/// Use case to purchase/unlock a course.
class PurchaseCourse implements UseCase<void, PurchaseCourseParams> {
  final CourseRepository _repository;

  PurchaseCourse(this._repository);

  @override
  Future<Either<Failure, void>> call(PurchaseCourseParams params) {
    return _repository.updateOwned(params.userId, params.courseId, true);
  }
}

class PurchaseCourseParams extends Equatable {
  final String userId;
  final int courseId;

  const PurchaseCourseParams({
    required this.userId,
    required this.courseId,
  });

  @override
  List<Object?> get props => [userId, courseId];
}
