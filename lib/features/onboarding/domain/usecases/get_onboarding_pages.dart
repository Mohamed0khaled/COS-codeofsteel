import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/onboarding_page_entity.dart';
import '../repositories/onboarding_repository.dart';

/// Use case for getting onboarding pages
class GetOnboardingPages {
  final OnboardingRepository repository;

  GetOnboardingPages(this.repository);

  Either<Failure, List<OnboardingPageEntity>> call() {
    return repository.getOnboardingPages();
  }
}
