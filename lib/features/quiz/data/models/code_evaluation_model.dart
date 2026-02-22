import '../../domain/entities/code_evaluation_entity.dart';

/// Data model for CodeEvaluation with JSON serialization.
class CodeEvaluationModel extends CodeEvaluationEntity {
  const CodeEvaluationModel({
    required super.question,
    required super.userCode,
    required super.score,
    super.maxScore,
    required super.explanation,
    required super.evaluatedAt,
  });

  /// Factory constructor from Map
  factory CodeEvaluationModel.fromMap(Map<String, dynamic> map) {
    return CodeEvaluationModel(
      question: map['question'] as String? ?? '',
      userCode: map['userCode'] as String? ?? '',
      score: map['score'] as int? ?? 0,
      maxScore: map['maxScore'] as int? ?? 25,
      explanation: map['explanation'] as String? ?? '',
      evaluatedAt: map['evaluatedAt'] != null
          ? DateTime.parse(map['evaluatedAt'] as String)
          : DateTime.now(),
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'userCode': userCode,
      'score': score,
      'maxScore': maxScore,
      'explanation': explanation,
      'evaluatedAt': evaluatedAt.toIso8601String(),
    };
  }

  /// Create from entity
  factory CodeEvaluationModel.fromEntity(CodeEvaluationEntity entity) {
    return CodeEvaluationModel(
      question: entity.question,
      userCode: entity.userCode,
      score: entity.score,
      maxScore: entity.maxScore,
      explanation: entity.explanation,
      evaluatedAt: entity.evaluatedAt,
    );
  }

  /// Parse from AI response
  factory CodeEvaluationModel.fromAiResponse({
    required String question,
    required String userCode,
    required String aiResponse,
  }) {
    // Parse score and explanation from AI response format: {score: ?, explanation: ?}
    final regex = RegExp(r'\{score:\s*(\d+),\s*explanation:\s*(.*?)\}', dotAll: true);
    final match = regex.firstMatch(aiResponse);

    int score = 0;
    String explanation = 'Unable to parse evaluation';

    if (match != null) {
      score = int.tryParse(match.group(1) ?? '0') ?? 0;
      explanation = match.group(2) ?? 'No explanation provided';
    }

    return CodeEvaluationModel(
      question: question,
      userCode: userCode,
      score: score,
      explanation: explanation,
      evaluatedAt: DateTime.now(),
    );
  }
}
