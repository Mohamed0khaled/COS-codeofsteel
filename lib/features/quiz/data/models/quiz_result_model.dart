import '../../domain/entities/quiz_result_entity.dart';

/// Data model for QuizResult with JSON serialization.
class QuizResultModel extends QuizResultEntity {
  const QuizResultModel({
    required super.quizId,
    required super.score,
    required super.totalQuestions,
    required super.selectedAnswers,
    required super.completedAt,
  });

  /// Factory constructor from Map
  factory QuizResultModel.fromMap(Map<String, dynamic> map) {
    final answersMap = (map['selectedAnswers'] as Map<String, dynamic>?)
            ?.map((key, value) => MapEntry(int.parse(key), value as int)) ??
        {};

    return QuizResultModel(
      quizId: map['quizId'] as String? ?? '',
      score: map['score'] as int? ?? 0,
      totalQuestions: map['totalQuestions'] as int? ?? 0,
      selectedAnswers: answersMap,
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'] as String)
          : DateTime.now(),
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'selectedAnswers':
          selectedAnswers.map((key, value) => MapEntry(key.toString(), value)),
      'completedAt': completedAt.toIso8601String(),
    };
  }

  /// Create from entity
  factory QuizResultModel.fromEntity(QuizResultEntity entity) {
    return QuizResultModel(
      quizId: entity.quizId,
      score: entity.score,
      totalQuestions: entity.totalQuestions,
      selectedAnswers: entity.selectedAnswers,
      completedAt: entity.completedAt,
    );
  }
}
