import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../repositories/onboarding_repository.dart';

/// Use case for completing onboarding
class CompleteOnboarding {
  final OnboardingRepository repository;

  CompleteOnboarding(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.completeOnboarding();
  }
}
