import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/quiz_entity.dart';
import '../entities/quiz_result_entity.dart';
import '../entities/code_evaluation_entity.dart';

/// Abstract repository defining quiz operations.
abstract class QuizRepository {
  /// Get a quiz by its ID
  Future<Either<Failure, QuizEntity>> getQuizById(String quizId);

  /// Get all quizzes for a course
  Future<Either<Failure, List<QuizEntity>>> getQuizzesByCourse(String courseId);

  /// Submit quiz answers and calculate score
  Future<Either<Failure, QuizResultEntity>> submitQuiz(
    String quizId,
    Map<int, int> selectedAnswers,
  );

  /// Get quiz history for a user
  Future<Either<Failure, List<QuizResultEntity>>> getQuizHistory(
    String userId,
    String courseId,
  );

  /// Save quiz result
  Future<Either<Failure, void>> saveQuizResult(
    String userId,
    QuizResultEntity result,
  );

  /// Evaluate code answer using AI
  Future<Either<Failure, CodeEvaluationEntity>> evaluateCode(
    String question,
    String userCode,
  );

  /// Store API key securely
  Future<Either<Failure, void>> storeApiKey(String apiKey);

  /// Get stored API key
  Future<Either<Failure, String?>> getApiKey();
}
