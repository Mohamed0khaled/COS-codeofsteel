import 'package:equatable/equatable.dart';

/// Domain entity representing a code quiz evaluation result.
class CodeEvaluationEntity extends Equatable {
  final String question;
  final String userCode;
  final int score;
  final int maxScore;
  final String explanation;
  final DateTime evaluatedAt;

  const CodeEvaluationEntity({
    required this.question,
    required this.userCode,
    required this.score,
    this.maxScore = 25,
    required this.explanation,
    required this.evaluatedAt,
  });

  /// Calculate percentage
  double get percentage => maxScore > 0 ? (score / maxScore) * 100 : 0;

  @override
  List<Object?> get props => [
        question,
        userCode,
        score,
        maxScore,
        explanation,
        evaluatedAt,
      ];
}
