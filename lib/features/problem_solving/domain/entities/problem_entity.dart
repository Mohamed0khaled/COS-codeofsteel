import 'package:equatable/equatable.dart';

/// Entity representing a coding problem
class ProblemEntity extends Equatable {
  final String id;
  final String question;
  final int level;
  final String? hint;
  final String? expectedOutput;

  const ProblemEntity({
    required this.id,
    required this.question,
    required this.level,
    this.hint,
    this.expectedOutput,
  });

  @override
  List<Object?> get props => [id, question, level, hint, expectedOutput];
}
