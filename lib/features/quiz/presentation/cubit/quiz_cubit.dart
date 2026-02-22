import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/evaluate_code.dart';
import '../../domain/usecases/get_quiz_by_id.dart';
import '../../domain/usecases/get_quiz_history.dart';
import '../../domain/usecases/get_quizzes_by_course.dart';
import '../../domain/usecases/save_quiz_result.dart';
import '../../domain/usecases/store_api_key.dart';
import '../../domain/usecases/submit_quiz.dart';
import 'quiz_state.dart';

/// Cubit for managing quiz-related state.
class QuizCubit extends Cubit<QuizState> {
  final GetQuizById _getQuizById;
  final GetQuizzesByCourse _getQuizzesByCourse;
  final SubmitQuiz _submitQuiz;
  final SaveQuizResult _saveQuizResult;
  final GetQuizHistory _getQuizHistory;
  final EvaluateCode _evaluateCode;
  final StoreApiKey _storeApiKey;

  QuizCubit({
    required GetQuizById getQuizById,
    required GetQuizzesByCourse getQuizzesByCourse,
    required SubmitQuiz submitQuiz,
    required SaveQuizResult saveQuizResult,
    required GetQuizHistory getQuizHistory,
    required EvaluateCode evaluateCode,
    required StoreApiKey storeApiKey,
  })  : _getQuizById = getQuizById,
        _getQuizzesByCourse = getQuizzesByCourse,
        _submitQuiz = submitQuiz,
        _saveQuizResult = saveQuizResult,
        _getQuizHistory = getQuizHistory,
        _evaluateCode = evaluateCode,
        _storeApiKey = storeApiKey,
        super(const QuizInitial());

  /// Load a specific quiz
  Future<void> loadQuiz(String quizId) async {
    emit(const QuizLoading());

    final result = await _getQuizById(quizId);

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (quiz) => emit(QuizLoaded(quiz: quiz)),
    );
  }

  /// Load all quizzes for a course
  Future<void> loadQuizzesByCourse(String courseId) async {
    emit(const QuizLoading());

    final result = await _getQuizzesByCourse(courseId);

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (quizzes) => emit(QuizzesListLoaded(quizzes)),
    );
  }

  /// Select an answer for a question
  void selectAnswer(int questionIndex, int optionIndex) {
    final currentState = state;
    if (currentState is QuizLoaded) {
      final newAnswers = Map<int, int>.from(currentState.selectedAnswers);
      newAnswers[questionIndex] = optionIndex;

      emit(currentState.copyWith(selectedAnswers: newAnswers));
    }
  }

  /// Navigate to next question
  void nextQuestion() {
    final currentState = state;
    if (currentState is QuizLoaded && !currentState.isLastQuestion) {
      emit(currentState.copyWith(
        currentQuestionIndex: currentState.currentQuestionIndex + 1,
      ));
    }
  }

  /// Navigate to previous question
  void previousQuestion() {
    final currentState = state;
    if (currentState is QuizLoaded && currentState.currentQuestionIndex > 0) {
      emit(currentState.copyWith(
        currentQuestionIndex: currentState.currentQuestionIndex - 1,
      ));
    }
  }

  /// Go to a specific question
  void goToQuestion(int index) {
    final currentState = state;
    if (currentState is QuizLoaded &&
        index >= 0 &&
        index < currentState.quiz.questions.length) {
      emit(currentState.copyWith(currentQuestionIndex: index));
    }
  }

  /// Submit the quiz and get result
  Future<void> submitCurrentQuiz() async {
    final currentState = state;
    if (currentState is! QuizLoaded) return;

    emit(const QuizLoading());

    final result = await _submitQuiz(
      SubmitQuizParams(
        quizId: currentState.quiz.id,
        selectedAnswers: currentState.selectedAnswers,
      ),
    );

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (quizResult) => emit(QuizSubmitted(quizResult)),
    );
  }

  /// Save quiz result for a user
  Future<void> saveResult(String userId) async {
    final currentState = state;
    if (currentState is! QuizSubmitted) return;

    final result = await _saveQuizResult(
      SaveQuizResultParams(
        userId: userId,
        result: currentState.result,
      ),
    );

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (_) {
        // Keep the submitted state, result is saved
      },
    );
  }

  /// Load quiz history for a user
  Future<void> loadQuizHistory(String userId, String courseId) async {
    emit(const QuizLoading());

    final result = await _getQuizHistory(
      GetQuizHistoryParams(userId: userId, courseId: courseId),
    );

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (history) => emit(QuizHistoryLoaded(history)),
    );
  }

  /// Evaluate code using AI
  Future<void> evaluateUserCode(String question, String userCode) async {
    emit(CodeEvaluating(question: question, userCode: userCode));

    final result = await _evaluateCode(
      EvaluateCodeParams(question: question, userCode: userCode),
    );

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (evaluation) => emit(CodeEvaluated(evaluation)),
    );
  }

  /// Store API key
  Future<void> storeApiKey(String apiKey) async {
    final result = await _storeApiKey(apiKey);

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (_) {
        // Key stored successfully, no state change needed
      },
    );
  }

  /// Reset quiz to initial state
  void resetQuiz() {
    emit(const QuizInitial());
  }
}
