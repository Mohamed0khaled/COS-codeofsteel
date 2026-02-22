import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/code_evaluation_entity.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/entities/quiz_result_entity.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_local_datasource.dart';
import '../datasources/quiz_remote_datasource.dart';
import '../models/quiz_result_model.dart';

/// Implementation of QuizRepository.
class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource _localDataSource;
  final QuizRemoteDataSource _remoteDataSource;
  final FirebaseFirestore _firestore;

  QuizRepositoryImpl({
    required QuizLocalDataSource localDataSource,
    required QuizRemoteDataSource remoteDataSource,
    FirebaseFirestore? firestore,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, QuizEntity>> getQuizById(String quizId) async {
    try {
      final quiz = _localDataSource.getQuizById(quizId);
      if (quiz != null) {
        return Right(quiz);
      }
      return Left(ServerFailure(message: 'Quiz not found: $quizId'));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get quiz: $e'));
    }
  }

  @override
  Future<Either<Failure, List<QuizEntity>>> getQuizzesByCourse(
    String courseId,
  ) async {
    try {
      final quizzes = _localDataSource.getQuizzesByCourse(courseId);
      return Right(quizzes);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get quizzes: $e'));
    }
  }

  @override
  Future<Either<Failure, QuizResultEntity>> submitQuiz(
    String quizId,
    Map<int, int> selectedAnswers,
  ) async {
    try {
      final quiz = _localDataSource.getQuizById(quizId);
      if (quiz == null) {
        return Left(ServerFailure(message: 'Quiz not found: $quizId'));
      }

      // Calculate score
      int score = 0;
      for (int i = 0; i < quiz.questions.length; i++) {
        if (selectedAnswers[i] == quiz.questions[i].answerIndex) {
          score++;
        }
      }

      final result = QuizResultEntity(
        quizId: quizId,
        score: score,
        totalQuestions: quiz.questions.length,
        selectedAnswers: selectedAnswers,
        completedAt: DateTime.now(),
      );

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to submit quiz: $e'));
    }
  }

  @override
  Future<Either<Failure, List<QuizResultEntity>>> getQuizHistory(
    String userId,
    String courseId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('quiz_results')
          .where('courseId', isEqualTo: courseId)
          .orderBy('completedAt', descending: true)
          .get();

      final results = snapshot.docs
          .map((doc) => QuizResultModel.fromMap(doc.data()))
          .toList();

      return Right(results);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get quiz history: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveQuizResult(
    String userId,
    QuizResultEntity result,
  ) async {
    try {
      final model = QuizResultModel.fromEntity(result);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('quiz_results')
          .add(model.toMap());

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to save quiz result: $e'));
    }
  }

  @override
  Future<Either<Failure, CodeEvaluationEntity>> evaluateCode(
    String question,
    String userCode,
  ) async {
    try {
      final result = await _remoteDataSource.evaluateCode(question, userCode);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to evaluate code: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> storeApiKey(String apiKey) async {
    try {
      await _remoteDataSource.storeApiKey(apiKey);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to store API key: $e'));
    }
  }

  @override
  Future<Either<Failure, String?>> getApiKey() async {
    try {
      final apiKey = await _remoteDataSource.getApiKey();
      return Right(apiKey);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get API key: $e'));
    }
  }
}
