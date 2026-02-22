import '../../domain/entities/problem_entity.dart';

/// Model for Problem with JSON serialization
class ProblemModel extends ProblemEntity {
  const ProblemModel({
    required super.id,
    required super.question,
    required super.level,
    super.hint,
    super.expectedOutput,
  });

  /// Create from JSON map
  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
      id: json['id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      level: json['level'] as int? ?? 0,
      hint: json['hint'] as String?,
      expectedOutput: json['expectedOutput'] as String?,
    );
  }

  /// Create from just a question string (for Firestore simple format)
  factory ProblemModel.fromQuestion(String question, int level) {
    return ProblemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      question: question,
      level: level,
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'level': level,
      'hint': hint,
      'expectedOutput': expectedOutput,
    };
  }

  /// Create from entity
  factory ProblemModel.fromEntity(ProblemEntity entity) {
    return ProblemModel(
      id: entity.id,
      question: entity.question,
      level: entity.level,
      hint: entity.hint,
      expectedOutput: entity.expectedOutput,
    );
  }
}
