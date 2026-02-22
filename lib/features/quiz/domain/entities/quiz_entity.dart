import 'package:equatable/equatable.dart';
import 'question_entity.dart';

/// Domain entity representing a quiz (collection of questions).
class QuizEntity extends Equatable {
  final String id;
  final String title;
  final String courseId;
  final List<QuestionEntity> questions;
  final int timeLimit; // in minutes

  const QuizEntity({
    required this.id,
    required this.title,
    required this.courseId,
    required this.questions,
    this.timeLimit = 15,
  });

  /// Total number of questions
  int get totalQuestions => questions.length;

  @override
  List<Object?> get props => [id, title, courseId, questions, timeLimit];
}
