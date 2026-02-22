import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_onboarding_pages.dart';
import '../../domain/usecases/is_onboarding_completed.dart';
import '../../domain/usecases/complete_onboarding.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingPages getOnboardingPages;
  final IsOnboardingCompleted isOnboardingCompleted;
  final CompleteOnboarding completeOnboarding;

  OnboardingCubit({
    required this.getOnboardingPages,
    required this.isOnboardingCompleted,
    required this.completeOnboarding,
  }) : super(const OnboardingInitial());

  /// Check if onboarding should be shown
  Future<void> checkOnboardingStatus() async {
    emit(const OnboardingLoading());

    final result = await isOnboardingCompleted();
    result.fold(
      (failure) => emit(const OnboardingCompletionStatus(isCompleted: false)),
      (isCompleted) => emit(OnboardingCompletionStatus(isCompleted: isCompleted)),
    );
  }

  /// Load onboarding pages
  void loadPages() {
    emit(const OnboardingLoading());

    final result = getOnboardingPages();
    result.fold(
      (failure) => emit(OnboardingError(message: failure.message)),
      (pages) => emit(OnboardingPagesLoaded(pages: pages, currentPage: 0)),
    );
  }

  /// Go to next page
  void nextPage() {
    final currentState = state;
    if (currentState is OnboardingPagesLoaded) {
      if (currentState.isLastPage) {
        // Complete onboarding
        finishOnboarding();
      } else {
        emit(currentState.copyWith(currentPage: currentState.currentPage + 1));
      }
    }
  }

  /// Go to previous page
  void previousPage() {
    final currentState = state;
    if (currentState is OnboardingPagesLoaded && currentState.currentPage > 0) {
      emit(currentState.copyWith(currentPage: currentState.currentPage - 1));
    }
  }

  /// Jump to specific page
  void goToPage(int page) {
    final currentState = state;
    if (currentState is OnboardingPagesLoaded) {
      if (page >= 0 && page < currentState.pages.length) {
        emit(currentState.copyWith(currentPage: page));
      }
    }
  }

  /// Skip onboarding and complete
  Future<void> skipOnboarding() async {
    await finishOnboarding();
  }

  /// Finish onboarding
  Future<void> finishOnboarding() async {
    final result = await completeOnboarding();
    result.fold(
      (failure) => emit(OnboardingError(message: failure.message)),
      (_) => emit(const OnboardingCompleted()),
    );
  }
}
