import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/problem_solving_repository.dart';

/// Use case for setting user's preferred programming language
class SetPreferredLanguage {
  final ProblemSolvingRepository repository;

  SetPreferredLanguage(this.repository);

  Future<Either<Failure, void>> call(String language) async {
    return await repository.setPreferredLanguage(language);
  }
}
