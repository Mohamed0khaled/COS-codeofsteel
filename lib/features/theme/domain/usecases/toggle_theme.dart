import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

/// Use case for toggling theme between dark and light
class ToggleTheme {
  final ThemeRepository repository;

  ToggleTheme(this.repository);

  Future<Either<Failure, ThemeEntity>> call() async {
    return await repository.toggleTheme();
  }
}
