import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course_entity.dart';
import '../repositories/course_repository.dart';

/// Use case to sync global courses catalog and get all courses for a user.
/// This fetches courses from the global 'courses' collection,
/// adds any missing ones to the user's collection, then returns all courses.
class SyncAndGetAllCourses implements UseCase<List<CourseEntity>, String> {
  final CourseRepository _repository;

  SyncAndGetAllCourses(this._repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(String userId) {
    return _repository.syncAndGetAllCourses(userId);
  }

}