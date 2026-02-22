import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/settings_entity.dart';

/// Abstract repository for Settings feature
abstract class SettingsRepository {
  /// Get current settings
  Future<Either<Failure, SettingsEntity>> getSettings();

  /// Update dark mode setting
  Future<Either<Failure, void>> setDarkMode(bool isDarkMode);

  /// Update language setting
  Future<Either<Failure, void>> setLanguage(String languageCode);

  /// Update programming language setting
  Future<Either<Failure, void>> setProgrammingLanguage(String language);

  /// Check if this is first app launch
  Future<Either<Failure, bool>> isFirstLaunch();

  /// Mark first launch as complete
  Future<Either<Failure, void>> completeFirstLaunch();
}
