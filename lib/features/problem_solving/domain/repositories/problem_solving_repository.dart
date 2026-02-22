import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../entities/problem_entity.dart';
import '../entities/problem_level_entity.dart';
import '../entities/solution_entity.dart';
import '../entities/evaluation_entity.dart';

/// Abstract repository for Problem Solving feature
abstract class ProblemSolvingRepository {
  /// Get a random problem by difficulty level
  Future<Either<Failure, ProblemEntity>> getRandomProblem(int level);

  /// Get all available difficulty levels
  Future<Either<Failure, List<ProblemLevelEntity>>> getAllLevels();

  /// Get level details by level number
  Future<Either<Failure, ProblemLevelEntity>> getLevelDetails(int level);

  /// Submit a solution for evaluation
  Future<Either<Failure, SolutionEntity>> submitSolution({
    required String problemId,
    required String question,
    required String code,
    required String language,
    required int level,
  });

  /// Evaluate a solution using AI
  Future<Either<Failure, EvaluationEntity>> evaluateSolution({
    required String solutionId,
    required String question,
    required String code,
    required String language,
    required ProblemLevelEntity levelDetails,
  });

  /// Save evaluation result
  Future<Either<Failure, void>> saveEvaluationResult(EvaluationEntity evaluation);

  /// Get solution history for current user
  Future<Either<Failure, List<EvaluationEntity>>> getSolutionHistory();

  /// Store Hugging Face API key securely
  Future<Either<Failure, void>> storeApiKey(String apiKey);

  /// Check if API key is stored
  Future<Either<Failure, bool>> hasApiKey();

  /// Get user's preferred programming language
  Future<Either<Failure, String>> getPreferredLanguage();

  /// Set user's preferred programming language
  Future<Either<Failure, void>> setPreferredLanguage(String language);
}
