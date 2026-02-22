import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/locale_entity.dart';

/// Abstract repository for Localization feature
abstract class LocaleRepository {
  /// Get current locale configuration
  Either<Failure, LocaleEntity> getLocale();

  /// Save locale configuration
  Future<Either<Failure, void>> saveLocale(String languageCode);

  /// Toggle locale between Arabic and English
  Future<Either<Failure, LocaleEntity>> toggleLocale();
}
