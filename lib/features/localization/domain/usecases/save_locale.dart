import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/locale_repository.dart';

/// Use case for saving locale preference
class SaveLocale {
  final LocaleRepository repository;

  SaveLocale(this.repository);

  Future<Either<Failure, void>> call(String languageCode) async {
    return await repository.saveLocale(languageCode);
  }
}
