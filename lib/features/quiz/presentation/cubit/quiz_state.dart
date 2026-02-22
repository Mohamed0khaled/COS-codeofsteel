import 'package:equatable/equatable.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/entities/quiz_result_entity.dart';
import '../../domain/entities/code_evaluation_entity.dart';

/// Base state for quiz
abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class QuizInitial extends QuizState {
  const QuizInitial();
}

/// Loading state
class QuizLoading extends QuizState {
  const QuizLoading();
}

/// State when a quiz is loaded and ready to take
class QuizLoaded extends QuizState {
  final QuizEntity quiz;
  final Map<int, int> selectedAnswers;
  final int currentQuestionIndex;

  const QuizLoaded({
    required this.quiz,
    this.selectedAnswers = const {},
    this.currentQuestionIndex = 0,
  });

  /// Create a copy with updated values
  QuizLoaded copyWith({
    QuizEntity? quiz,
    Map<int, int>? selectedAnswers,
    int? currentQuestionIndex,
  }) {
    return QuizLoaded(
      quiz: quiz ?? this.quiz,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }

  /// Check if all questions are answered
  bool get isComplete => selectedAnswers.length == quiz.questions.length;

  /// Check if current question is answered
  bool get isCurrentAnswered => selectedAnswers.containsKey(currentQuestionIndex);

  /// Check if this is the last question
  bool get isLastQuestion => currentQuestionIndex == quiz.questions.length - 1;

  @override
  List<Object?> get props => [quiz, selectedAnswers, currentQuestionIndex];
}

/// State when list of quizzes is loaded
class QuizzesListLoaded extends QuizState {
  final List<QuizEntity> quizzes;

  const QuizzesListLoaded(this.quizzes);

  @override
  List<Object?> get props => [quizzes];
}

/// State when quiz is submitted and result is available
class QuizSubmitted extends QuizState {
  final QuizResultEntity result;

  const QuizSubmitted(this.result);

  @override
  List<Object?> get props => [result];
}

/// State when quiz history is loaded
class QuizHistoryLoaded extends QuizState {
  final List<QuizResultEntity> history;

  const QuizHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

/// State when code is being evaluated
class CodeEvaluating extends QuizState {
  final String question;
  final String userCode;

  const CodeEvaluating({
    required this.question,
    required this.userCode,
  });

  @override
  List<Object?> get props => [question, userCode];
}

/// State when code evaluation is complete
class CodeEvaluated extends QuizState {
  final CodeEvaluationEntity evaluation;

  const CodeEvaluated(this.evaluation);

  @override
  List<Object?> get props => [evaluation];
}

/// Error state
class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
