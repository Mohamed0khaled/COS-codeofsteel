import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quiz_entity.dart';
import '../repositories/quiz_repository.dart';

/// Use case to get a quiz by its ID.
class GetQuizById implements UseCase<QuizEntity, String> {
  final QuizRepository _repository;

  GetQuizById(this._repository);

  @override
  Future<Either<Failure, QuizEntity>> call(String quizId) {
    return _repository.getQuizById(quizId);
  }
}
