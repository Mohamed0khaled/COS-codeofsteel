import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/settings_repository.dart';

/// Use case for completing first launch (mark as seen)
class CompleteFirstLaunch {
  final SettingsRepository repository;

  CompleteFirstLaunch(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.completeFirstLaunch();
  }
}
