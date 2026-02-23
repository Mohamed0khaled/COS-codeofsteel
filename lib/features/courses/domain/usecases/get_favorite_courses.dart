import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course_entity.dart';
import '../repositories/course_repository.dart';

/// Use case to get all favorite courses for a user.
class GetFavoriteCourses implements UseCase<List<CourseEntity>, String> {
  final CourseRepository _repository;

  GetFavoriteCourses(this._repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(String userId) {
    return _repository.getFavoriteCourses(userId);
  }

}