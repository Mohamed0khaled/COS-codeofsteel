import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/onboarding_page_entity.dart';

/// Local data source for Onboarding
abstract class OnboardingLocalDataSource {
  /// Get onboarding pages
  List<OnboardingPageEntity> getOnboardingPages();

  /// Check if onboarding is completed
  Future<bool> isOnboardingCompleted();

  /// Mark onboarding as completed
  Future<void> completeOnboarding();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _onboardingCompletedKey = 'first_time';

  OnboardingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  List<OnboardingPageEntity> getOnboardingPages() {
    return OnboardingPages.pages;
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    // Returns true if NOT first time (onboarding is completed)
    final isFirstTime = sharedPreferences.getBool(_onboardingCompletedKey) ?? true;
    return !isFirstTime;
  }

  @override
  Future<void> completeOnboarding() async {
    await sharedPreferences.setBool(_onboardingCompletedKey, false);
  }
}
