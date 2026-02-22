import 'package:equatable/equatable.dart';

/// Domain entity representing a quiz result.
class QuizResultEntity extends Equatable {
  final String quizId;
  final int score;
  final int totalQuestions;
  final Map<int, int> selectedAnswers; // questionIndex -> selectedOptionIndex
  final DateTime completedAt;

  const QuizResultEntity({
    required this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.selectedAnswers,
    required this.completedAt,
  });

  /// Calculate percentage score
  double get percentage => totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;

  /// Check if passed (>= 60%)
  bool get passed => percentage >= 60;

  @override
  List<Object?> get props => [quizId, score, totalQuestions, selectedAnswers, completedAt];
}
