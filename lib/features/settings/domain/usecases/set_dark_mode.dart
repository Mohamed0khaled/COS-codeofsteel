import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/settings_repository.dart';

/// Use case for setting dark mode
class SetDarkMode {
  final SettingsRepository repository;

  SetDarkMode(this.repository);

  Future<Either<Failure, void>> call(bool isDarkMode) async {
    return await repository.setDarkMode(isDarkMode);
  }
}
