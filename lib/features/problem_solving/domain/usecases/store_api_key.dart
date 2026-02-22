import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for storing API key securely
class StoreProblemSolvingApiKey {
  final ProblemSolvingRepository repository;

  StoreProblemSolvingApiKey(this.repository);

  Future<Either<Failure, void>> call(String apiKey) async {
    return await repository.storeApiKey(apiKey);
  }
}
