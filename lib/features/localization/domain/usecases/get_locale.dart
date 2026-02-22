import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/locale_entity.dart';
import '../repositories/locale_repository.dart';

/// Use case for getting current locale
class GetLocale {
  final LocaleRepository repository;

  GetLocale(this.repository);

  Either<Failure, LocaleEntity> call() {
    return repository.getLocale();
  }
}
