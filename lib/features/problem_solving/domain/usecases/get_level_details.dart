import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/problem_level_entity.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for getting level details by level number
class GetLevelDetails {
  final ProblemSolvingRepository repository;

  GetLevelDetails(this.repository);

  Future<Either<Failure, ProblemLevelEntity>> call(int level) async {
    return await repository.getLevelDetails(level);
  }
}
