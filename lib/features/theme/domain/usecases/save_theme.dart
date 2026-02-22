import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/theme_repository.dart';

/// Use case for saving theme preference
class SaveTheme {
  final ThemeRepository repository;

  SaveTheme(this.repository);

  Future<Either<Failure, void>> call(bool isDarkMode) async {
    return await repository.saveTheme(isDarkMode);
  }
}
