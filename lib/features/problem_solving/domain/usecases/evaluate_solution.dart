import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/evaluation_entity.dart';
import '../entities/problem_level_entity.dart';
import '../repositories/problem_solving_repository.dart';

/// Parameters for evaluating a solution
class EvaluateSolutionParams {
  final String solutionId;
  final String question;
  final String code;
  final String language;
  final ProblemLevelEntity levelDetails;

  const EvaluateSolutionParams({
    required this.solutionId,
    required this.question,
    required this.code,
    required this.language,
    required this.levelDetails,
  });
}

/// Use case for evaluating a solution using AI
class EvaluateSolution {
  final ProblemSolvingRepository repository;

  EvaluateSolution(this.repository);

  Future<Either<Failure, EvaluationEntity>> call(EvaluateSolutionParams params) async {
    return await repository.evaluateSolution(
      solutionId: params.solutionId,
      question: params.question,
      code: params.code,
      language: params.language,
      levelDetails: params.levelDetails,
    );
  }
}
