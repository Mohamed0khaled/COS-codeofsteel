import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/settings_repository.dart';

/// Use case for setting app language
class SetLanguage {
  final SettingsRepository repository;

  SetLanguage(this.repository);

  Future<Either<Failure, void>> call(String languageCode) async {
    return await repository.setLanguage(languageCode);
  }
}
