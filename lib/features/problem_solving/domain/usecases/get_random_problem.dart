import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/problem_entity.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for getting a random problem by level
class GetRandomProblem {
  final ProblemSolvingRepository repository;

  GetRandomProblem(this.repository);

  Future<Either<Failure, ProblemEntity>> call(int level) async {
    return await repository.getRandomProblem(level);
  }
}
