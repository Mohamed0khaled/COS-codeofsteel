import '../../domain/entities/evaluation_entity.dart';

/// Model for Evaluation with JSON serialization
class EvaluationModel extends EvaluationEntity {
  const EvaluationModel({
    required super.id,
    required super.solutionId,
    required super.score,
    required super.totalScore,
    required super.accuracyScore,
    required super.efficiencyScore,
    required super.readabilityScore,
    required super.explanation,
    required super.evaluatedAt,
  });

  /// Create from JSON map
  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      id: json['id'] as String? ?? '',
      solutionId: json['solutionId'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      totalScore: json['totalScore'] as int? ?? 0,
      accuracyScore: json['accuracyScore'] as int? ?? 0,
      efficiencyScore: json['efficiencyScore'] as int? ?? 0,
      readabilityScore: json['readabilityScore'] as int? ?? 0,
      explanation: json['explanation'] as String? ?? '',
      evaluatedAt: json['evaluatedAt'] != null
          ? DateTime.parse(json['evaluatedAt'] as String)
          : DateTime.now(),
    );
  }

  /// Create from AI response parsing
  factory EvaluationModel.fromAiResponse({
    required String solutionId,
    required int score,
    required String explanation,
    required int totalScore,
    required int accuracyScore,
    required int efficiencyScore,
    required int readabilityScore,
  }) {
    return EvaluationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      solutionId: solutionId,
      score: score,
      totalScore: totalScore,
      accuracyScore: accuracyScore,
      efficiencyScore: efficiencyScore,
      readabilityScore: readabilityScore,
      explanation: explanation,
      evaluatedAt: DateTime.now(),
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'solutionId': solutionId,
      'score': score,
      'totalScore': totalScore,
      'accuracyScore': accuracyScore,
      'efficiencyScore': efficiencyScore,
      'readabilityScore': readabilityScore,
      'explanation': explanation,
      'evaluatedAt': evaluatedAt.toIso8601String(),
    };
  }

  /// Create from entity
  factory EvaluationModel.fromEntity(EvaluationEntity entity) {
    return EvaluationModel(
      id: entity.id,
      solutionId: entity.solutionId,
      score: entity.score,
      totalScore: entity.totalScore,
      accuracyScore: entity.accuracyScore,
      efficiencyScore: entity.efficiencyScore,
      readabilityScore: entity.readabilityScore,
      explanation: entity.explanation,
      evaluatedAt: entity.evaluatedAt,
    );
  }
}
