import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/evaluation_entity.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for getting solution history
class GetSolutionHistory {
  final ProblemSolvingRepository repository;

  GetSolutionHistory(this.repository);

  Future<Either<Failure, List<EvaluationEntity>>> call() async {
    return await repository.getSolutionHistory();
  }
}
