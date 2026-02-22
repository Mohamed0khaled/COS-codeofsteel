import '../../domain/entities/question_entity.dart';

/// Data model for Question with JSON serialization.
class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.question,
    required super.options,
    required super.answerIndex,
  });

  /// Factory constructor from Map (used for local quiz data)
  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'] as String? ?? '',
      options: List<String>.from(map['options'] ?? []),
      answerIndex: map['answerIndex'] as int? ?? 0,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'answerIndex': answerIndex,
    };
  }

  /// Create from entity
  factory QuestionModel.fromEntity(QuestionEntity entity) {
    return QuestionModel(
      question: entity.question,
      options: entity.options,
      answerIndex: entity.answerIndex,
    );
  }
}
