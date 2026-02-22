import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for getting user's preferred programming language
class GetPreferredLanguage {
  final ProblemSolvingRepository repository;

  GetPreferredLanguage(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getPreferredLanguage();
  }
}
