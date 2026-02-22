import 'package:equatable/equatable.dart';
import '../../domain/entities/onboarding_page_entity.dart';

/// Base state for Onboarding
abstract class OnboardingState extends Equatable {
  const OnboardingState();
  
  @override
  List<Object?> get props => [];
}

/// Initial state
class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// Loading state
class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

/// Onboarding pages loaded
class OnboardingPagesLoaded extends OnboardingState {
  final List<OnboardingPageEntity> pages;
  final int currentPage;

  const OnboardingPagesLoaded({
    required this.pages,
    this.currentPage = 0,
  });

  /// Check if on last page
  bool get isLastPage => currentPage >= pages.length - 1;

  /// Get current page entity
  OnboardingPageEntity get currentPageEntity => pages[currentPage];

  /// Create copy with new current page
  OnboardingPagesLoaded copyWith({int? currentPage}) {
    return OnboardingPagesLoaded(
      pages: pages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [pages, currentPage];
}

/// Onboarding completion status
class OnboardingCompletionStatus extends OnboardingState {
  final bool isCompleted;

  const OnboardingCompletionStatus({required this.isCompleted});

  @override
  List<Object?> get props => [isCompleted];
}

/// Onboarding completed - navigate to auth
class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}

/// Error state
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError({required this.message});

  @override
  List<Object?> get props => [message];
}
