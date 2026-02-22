import 'package:equatable/equatable.dart';

/// Entity representing an onboarding page
class OnboardingPageEntity extends Equatable {
  final int index;
  final String imagePath;
  final String title;
  final String description;
  final bool isLastPage;

  const OnboardingPageEntity({
    required this.index,
    required this.imagePath,
    required this.title,
    required this.description,
    this.isLastPage = false,
  });

  @override
  List<Object?> get props => [index, imagePath, title, description, isLastPage];
}

/// Static onboarding pages data
class OnboardingPages {
  static const List<OnboardingPageEntity> pages = [
    OnboardingPageEntity(
      index: 0,
      imagePath: 'images/welcome/w-icon-1.png',
      title: 'Learn Programming Easily',
      description: 'Learn programming from your phone easily through many tools that save you from using a computer',
    ),
    OnboardingPageEntity(
      index: 1,
      imagePath: 'images/welcome/w-icon-2.png',
      title: 'Interactive Quizzes',
      description: 'Quizzes for each lesson, including multiple choice questions and questions by writing the code.',
    ),
    OnboardingPageEntity(
      index: 2,
      imagePath: 'images/welcome/w-icon-3.png',
      title: 'Track Your Progress',
      description: 'Statistics about your current level and progress so that you can know your development in a continuous and organized manner.',
    ),
    OnboardingPageEntity(
      index: 3,
      imagePath: 'images/welcome/w-icon-4.png',
      title: 'Complete Learning Experience',
      description: 'A complete computer in your hand to learn programming languages. You can learn the entire courses using this program without the need for a computer',
      isLastPage: true,
    ),
  ];

  static int get totalPages => pages.length;
}
