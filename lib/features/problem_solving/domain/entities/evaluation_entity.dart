import 'package:equatable/equatable.dart';

/// Entity representing AI evaluation result of a solution
class EvaluationEntity extends Equatable {
  final String id;
  final String solutionId;
  final int score;
  final int totalScore;
  final int accuracyScore;
  final int efficiencyScore;
  final int readabilityScore;
  final String explanation;
  final DateTime evaluatedAt;

  const EvaluationEntity({
    required this.id,
    required this.solutionId,
    required this.score,
    required this.totalScore,
    required this.accuracyScore,
    required this.efficiencyScore,
    required this.readabilityScore,
    required this.explanation,
    required this.evaluatedAt,
  });

  /// Calculate score percentage
  double get scorePercentage => totalScore > 0 ? score / totalScore : 0.0;

  /// Check if solution passed (>= 50% score)
  bool get isPassed => scorePercentage >= 0.5;

  @override
  List<Object?> get props => [
        id,
        solutionId,
        score,
        totalScore,
        accuracyScore,
        efficiencyScore,
        readabilityScore,
        explanation,
        evaluatedAt,
      ];
}
