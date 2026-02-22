import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course_entity.dart';
import '../repositories/course_repository.dart';

/// Use case to add or initialize a course for a user.
class AddCourse implements UseCase<void, AddCourseParams> {
  final CourseRepository _repository;

  AddCourse(this._repository);

  @override
  Future<Either<Failure, void>> call(AddCourseParams params) async {
    // Check if course already exists
    final existsResult = await _repository.courseExists(
      params.userId,
      params.course.id,
    );

    return existsResult.fold(
      (failure) => Left(failure),
      (exists) {
        if (exists) {
          return const Right(null); // Course already exists
        }
        return _repository.addCourse(params.userId, params.course);
      },
    );
  }
}

class AddCourseParams extends Equatable {
  final String userId;
  final CourseEntity course;

  const AddCourseParams({
    required this.userId,
    required this.course,
  });

  @override
  List<Object?> get props => [userId, course];
}
