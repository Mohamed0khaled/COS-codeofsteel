import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/onboarding_repository.dart';

/// Use case for checking if onboarding is completed
class IsOnboardingCompleted {
  final OnboardingRepository repository;

  IsOnboardingCompleted(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.isOnboardingCompleted();
  }
}
