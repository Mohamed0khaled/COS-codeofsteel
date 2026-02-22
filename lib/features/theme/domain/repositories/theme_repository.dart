import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/theme_entity.dart';

/// Abstract repository for Theme feature
abstract class ThemeRepository {
  /// Get current theme configuration
  Either<Failure, ThemeEntity> getTheme();

  /// Save theme configuration
  Future<Either<Failure, void>> saveTheme(bool isDarkMode);

  /// Toggle theme (dark/light)
  Future<Either<Failure, ThemeEntity>> toggleTheme();
}
