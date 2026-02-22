import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/solution_entity.dart';
import '../repositories/problem_solving_repository.dart';

/// Parameters for submitting a solution
class SubmitSolutionParams {
  final String problemId;
  final String question;
  final String code;
  final String language;
  final int level;

  const SubmitSolutionParams({
    required this.problemId,
    required this.question,
    required this.code,
    required this.language,
    required this.level,
  });
}

/// Use case for submitting a solution
class SubmitSolution {
  final ProblemSolvingRepository repository;

  SubmitSolution(this.repository);

  Future<Either<Failure, SolutionEntity>> call(SubmitSolutionParams params) async {
    return await repository.submitSolution(
      problemId: params.problemId,
      question: params.question,
      code: params.code,
      language: params.language,
      level: params.level,
    );
  }
}
