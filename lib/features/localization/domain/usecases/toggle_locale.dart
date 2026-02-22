import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/locale_entity.dart';
import '../repositories/locale_repository.dart';

/// Use case for toggling locale between Arabic and English
class ToggleLocale {
  final LocaleRepository repository;

  ToggleLocale(this.repository);

  Future<Either<Failure, LocaleEntity>> call() async {
    return await repository.toggleLocale();
  }
}
