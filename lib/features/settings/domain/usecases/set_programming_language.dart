import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/settings_repository.dart';

/// Use case for setting programming language preference
class SetProgrammingLanguage {
  final SettingsRepository repository;

  SetProgrammingLanguage(this.repository);

  Future<Either<Failure, void>> call(String language) async {
    return await repository.setProgrammingLanguage(language);
  }
}
