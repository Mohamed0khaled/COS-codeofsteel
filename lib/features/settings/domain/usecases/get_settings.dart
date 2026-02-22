import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

/// Use case for getting current settings
class GetSettings {
  final SettingsRepository repository;

  GetSettings(this.repository);

  Future<Either<Failure, SettingsEntity>> call() async {
    return await repository.getSettings();
  }
}
