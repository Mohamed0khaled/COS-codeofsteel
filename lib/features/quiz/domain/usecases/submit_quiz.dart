import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quiz_result_entity.dart';
import '../repositories/quiz_repository.dart';

/// Use case to submit quiz answers and get result.
class SubmitQuiz implements UseCase<QuizResultEntity, SubmitQuizParams> {
  final QuizRepository _repository;

  SubmitQuiz(this._repository);

  @override
  Future<Either<Failure, QuizResultEntity>> call(SubmitQuizParams params) {
    return _repository.submitQuiz(params.quizId, params.selectedAnswers);
  }
}

class SubmitQuizParams extends Equatable {
  final String quizId;
  final Map<int, int> selectedAnswers;

  const SubmitQuizParams({
    required this.quizId,
    required this.selectedAnswers,
  });

  @override
  List<Object?> get props => [quizId, selectedAnswers];
}
