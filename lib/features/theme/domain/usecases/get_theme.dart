import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

/// Use case for getting current theme
class GetTheme {
  final ThemeRepository repository;

  GetTheme(this.repository);

  Either<Failure, ThemeEntity> call() {
    return repository.getTheme();
  }
}
