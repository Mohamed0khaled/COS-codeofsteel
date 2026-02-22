import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../../domain/entities/problem_entity.dart';
import '../../domain/entities/problem_level_entity.dart';
import '../../domain/entities/solution_entity.dart';
import '../../domain/entities/evaluation_entity.dart';
import '../../domain/repositories/problem_solving_repository.dart';
import '../datasources/problem_solving_remote_datasource.dart';
import '../datasources/problem_solving_local_datasource.dart';
import '../datasources/ai_evaluation_datasource.dart';
import '../models/solution_model.dart';
import '../models/evaluation_model.dart';

class ProblemSolvingRepositoryImpl implements ProblemSolvingRepository {
  final ProblemSolvingRemoteDataSource remoteDataSource;
  final ProblemSolvingLocalDataSource localDataSource;
  final AiEvaluationDataSource aiDataSource;
  final FirebaseAuth firebaseAuth;

  ProblemSolvingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.aiDataSource,
    required this.firebaseAuth,
  });

  String? get _currentUserId => firebaseAuth.currentUser?.uid;

  @override
  Future<Either<Failure, ProblemEntity>> getRandomProblem(int level) async {
    try {
      final problem = await remoteDataSource.getRandomProblem(level);
      return Right(problem);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProblemLevelEntity>>> getAllLevels() async {
    try {
      final levels = localDataSource.getAllLevels();
      return Right(levels);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProblemLevelEntity>> getLevelDetails(int level) async {
    try {
      final levelDetails = localDataSource.getLevelDetails(level);
      return Right(levelDetails);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SolutionEntity>> submitSolution({
    required String problemId,
    required String question,
    required String code,
    required String language,
    required int level,
  }) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return Left(AuthFailure(message: 'User not authenticated'));
      }

      final solution = SolutionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        problemId: problemId,
        userId: userId,
        code: code,
        language: language,
        level: level,
        submittedAt: DateTime.now(),
      );

      return Right(solution);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EvaluationEntity>> evaluateSolution({
    required String solutionId,
    required String question,
    required String code,
    required String language,
    required ProblemLevelEntity levelDetails,
  }) async {
    try {
      final apiKey = await localDataSource.getApiKey();
      if (apiKey == null || apiKey.isEmpty) {
        return Left(CacheFailure(message: 'API key not configured'));
      }

      final evaluation = await aiDataSource.evaluateCode(
        apiKey: apiKey,
        question: question,
        code: code,
        language: language,
        levelDetails: levelDetails,
        solutionId: solutionId,
      );

      return Right(evaluation);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveEvaluationResult(EvaluationEntity evaluation) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return Left(AuthFailure(message: 'User not authenticated'));
      }

      final evaluationModel = EvaluationModel.fromEntity(evaluation);
      await remoteDataSource.saveEvaluationResult(evaluationModel, userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EvaluationEntity>>> getSolutionHistory() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return Left(AuthFailure(message: 'User not authenticated'));
      }

      final history = await remoteDataSource.getSolutionHistory(userId);
      return Right(history);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> storeApiKey(String apiKey) async {
    try {
      await localDataSource.storeApiKey(apiKey);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> hasApiKey() async {
    try {
      final hasKey = await localDataSource.hasApiKey();
      return Right(hasKey);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getPreferredLanguage() async {
    try {
      final language = await localDataSource.getPreferredLanguage();
      return Right(language);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setPreferredLanguage(String language) async {
    try {
      await localDataSource.setPreferredLanguage(language);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
