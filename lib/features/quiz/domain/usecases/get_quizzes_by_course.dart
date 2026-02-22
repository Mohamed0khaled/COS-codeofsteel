import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quiz_entity.dart';
import '../repositories/quiz_repository.dart';

/// Use case to get all quizzes for a course.
class GetQuizzesByCourse implements UseCase<List<QuizEntity>, String> {
  final QuizRepository _repository;

  GetQuizzesByCourse(this._repository);

  @override
  Future<Either<Failure, List<QuizEntity>>> call(String courseId) {
    return _repository.getQuizzesByCourse(courseId);
  }
}
