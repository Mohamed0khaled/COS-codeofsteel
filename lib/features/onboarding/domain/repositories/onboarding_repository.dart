import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/onboarding_page_entity.dart';

/// Abstract repository for Onboarding feature
abstract class OnboardingRepository {
  /// Get all onboarding pages
  Either<Failure, List<OnboardingPageEntity>> getOnboardingPages();

  /// Check if onboarding is completed
  Future<Either<Failure, bool>> isOnboardingCompleted();

  /// Mark onboarding as completed
  Future<Either<Failure, void>> completeOnboarding();
}
