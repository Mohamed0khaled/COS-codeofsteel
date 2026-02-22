import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/settings_repository.dart';

/// Use case for checking if first app launch
class IsFirstLaunch {
  final SettingsRepository repository;

  IsFirstLaunch(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.isFirstLaunch();
  }
}
