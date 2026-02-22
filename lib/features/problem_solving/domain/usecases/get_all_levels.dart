import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/problem_level_entity.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for getting all available difficulty levels
class GetAllLevels {
  final ProblemSolvingRepository repository;

  GetAllLevels(this.repository);

  Future<Either<Failure, List<ProblemLevelEntity>>> call() async {
    return await repository.getAllLevels();
  }
}
