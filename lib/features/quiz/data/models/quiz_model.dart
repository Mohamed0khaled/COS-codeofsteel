import '../../domain/entities/quiz_entity.dart';
import 'question_model.dart';

/// Data model for Quiz with JSON serialization.
class QuizModel extends QuizEntity {
  const QuizModel({
    required super.id,
    required super.title,
    required super.courseId,
    required super.questions,
    super.timeLimit,
  });

  /// Factory constructor from Map
  factory QuizModel.fromMap(Map<String, dynamic> map) {
    final questionsList = (map['questions'] as List?)
            ?.map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
            .toList() ??
        [];

    return QuizModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      courseId: map['courseId'] as String? ?? '',
      questions: questionsList,
      timeLimit: map['timeLimit'] as int? ?? 15,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'courseId': courseId,
      'questions': questions
          .map((q) => QuestionModel.fromEntity(q).toMap())
          .toList(),
      'timeLimit': timeLimit,
    };
  }

  /// Create from entity
  factory QuizModel.fromEntity(QuizEntity entity) {
    return QuizModel(
      id: entity.id,
      title: entity.title,
      courseId: entity.courseId,
      questions: entity.questions,
      timeLimit: entity.timeLimit,
    );
  }

  /// Create from legacy quiz data format (List<Map<String, dynamic>>)
  factory QuizModel.fromLegacyQuestions({
    required String id,
    required String title,
    required String courseId,
    required List<Map<String, dynamic>> questions,
    int timeLimit = 15,
  }) {
    return QuizModel(
      id: id,
      title: title,
      courseId: courseId,
      questions: questions.map((q) => QuestionModel.fromMap(q)).toList(),
      timeLimit: timeLimit,
    );
  }
}
