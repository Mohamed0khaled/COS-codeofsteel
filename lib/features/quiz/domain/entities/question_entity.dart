import 'package:equatable/equatable.dart';

/// Domain entity representing a quiz question.
class QuestionEntity extends Equatable {
  final String question;
  final List<String> options;
  final int answerIndex;

  const QuestionEntity({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  /// Check if the selected option is correct
  bool isCorrect(int selectedIndex) => selectedIndex == answerIndex;

  @override
  List<Object?> get props => [question, options, answerIndex];
}
