import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course_entity.dart';
import '../repositories/course_repository.dart';

/// Use case to get details of a specific course.
class GetCourseDetails implements UseCase<CourseEntity?, GetCourseDetailsParams> {
  final CourseRepository _repository;

  GetCourseDetails(this._repository);

  @override
  Future<Either<Failure, CourseEntity?>> call(GetCourseDetailsParams params) {
    return _repository.getCourseDetails(params.userId, params.courseId);
  }
}

class GetCourseDetailsParams extends Equatable {
  final String userId;
  final int courseId;

  const GetCourseDetailsParams({
    required this.userId,
    required this.courseId,
  });

  @override
  List<Object?> get props => [userId, courseId];
}
