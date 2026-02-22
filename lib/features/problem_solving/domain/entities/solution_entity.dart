import 'package:equatable/equatable.dart';

/// Entity representing a user's submitted solution
class SolutionEntity extends Equatable {
  final String id;
  final String problemId;
  final String userId;
  final String code;
  final String language;
  final int level;
  final DateTime submittedAt;

  const SolutionEntity({
    required this.id,
    required this.problemId,
    required this.userId,
    required this.code,
    required this.language,
    required this.level,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [
        id,
        problemId,
        userId,
        code,
        language,
        level,
        submittedAt,
      ];
}
