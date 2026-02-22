import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/evaluation_entity.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for saving evaluation result
class SaveEvaluationResult {
  final ProblemSolvingRepository repository;

  SaveEvaluationResult(this.repository);

  Future<Either<Failure, void>> call(EvaluationEntity evaluation) async {
    return await repository.saveEvaluationResult(evaluation);
  }
}
