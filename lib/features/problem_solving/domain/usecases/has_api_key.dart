import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for checking if API key exists
class HasApiKey {
  final ProblemSolvingRepository repository;

  HasApiKey(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.hasApiKey();
  }
}
