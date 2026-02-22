import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_random_problem.dart';
import '../../domain/usecases/get_all_levels.dart';
import '../../domain/usecases/get_level_details.dart';
import '../../domain/usecases/submit_solution.dart';
import '../../domain/usecases/evaluate_solution.dart';
import '../../domain/usecases/save_evaluation_result.dart';
import '../../domain/usecases/get_solution_history.dart';
import '../../domain/usecases/store_api_key.dart';
import '../../domain/usecases/has_api_key.dart';
import '../../domain/usecases/get_preferred_language.dart';
import '../../domain/usecases/set_preferred_language.dart';
import 'problem_solving_state.dart';

class ProblemSolvingCubit extends Cubit<ProblemSolvingState> {
  final GetRandomProblem getRandomProblem;
  final GetAllLevels getAllLevels;
  final GetLevelDetails getLevelDetails;
  final SubmitSolution submitSolution;
  final EvaluateSolution evaluateSolution;
  final SaveEvaluationResult saveEvaluationResult;
  final GetSolutionHistory getSolutionHistory;
  final StoreProblemSolvingApiKey storeApiKey;
  final HasApiKey hasApiKey;
  final GetPreferredLanguage getPreferredLanguage;
  final SetPreferredLanguage setPreferredLanguage;

  ProblemSolvingCubit({
    required this.getRandomProblem,
    required this.getAllLevels,
    required this.getLevelDetails,
    required this.submitSolution,
    required this.evaluateSolution,
    required this.saveEvaluationResult,
    required this.getSolutionHistory,
    required this.storeApiKey,
    required this.hasApiKey,
    required this.getPreferredLanguage,
    required this.setPreferredLanguage,
  }) : super(const ProblemSolvingInitial());

  /// Load all available levels and preferred language
  Future<void> loadLevels() async {
    emit(const ProblemSolvingLoading());

    final levelsResult = await getAllLevels();
    final languageResult = await getPreferredLanguage();

    levelsResult.fold(
      (failure) => emit(ProblemSolvingError(message: failure.message)),
      (levels) {
        languageResult.fold(
          (failure) => emit(LevelsLoaded(levels: levels, preferredLanguage: 'cpp')),
          (language) => emit(LevelsLoaded(levels: levels, preferredLanguage: language)),
        );
      },
    );
  }

  /// Load a random problem for a specific level
  Future<void> loadProblem(int level, String language) async {
    emit(const ProblemSolvingLoading());

    final problemResult = await getRandomProblem(level);
    final levelResult = await getLevelDetails(level);

    problemResult.fold(
      (failure) => emit(ProblemSolvingError(message: failure.message)),
      (problem) {
        levelResult.fold(
          (failure) => emit(ProblemSolvingError(message: failure.message)),
          (levelDetails) => emit(ProblemLoaded(
            problem: problem,
            levelDetails: levelDetails,
            language: language,
          )),
        );
      },
    );
  }

  /// Submit a solution and evaluate it
  Future<void> submitAndEvaluate({
    required String problemId,
    required String question,
    required String code,
    required String language,
    required int level,
  }) async {
    // First check if API key is available
    final hasKeyResult = await hasApiKey();
    final hasKeyValue = hasKeyResult.fold((_) => false, (value) => value);
    
    if (!hasKeyValue) {
      emit(const ProblemSolvingError(message: 'API key not configured. Please add your Hugging Face API key in settings.'));
      return;
    }

    // Submit the solution
    final submitResult = await submitSolution(SubmitSolutionParams(
      problemId: problemId,
      question: question,
      code: code,
      language: language,
      level: level,
    ));

    await submitResult.fold(
      (failure) async => emit(ProblemSolvingError(message: failure.message)),
      (solution) async {
        emit(SolutionSubmitted(solution: solution));
        emit(const Evaluating());

        // Get level details for evaluation
        final levelResult = await getLevelDetails(level);
        
        await levelResult.fold(
          (failure) async => emit(ProblemSolvingError(message: failure.message)),
          (levelDetails) async {
            // Evaluate the solution
            final evaluateResult = await evaluateSolution(EvaluateSolutionParams(
              solutionId: solution.id,
              question: question,
              code: code,
              language: language,
              levelDetails: levelDetails,
            ));

            await evaluateResult.fold(
              (failure) async => emit(ProblemSolvingError(message: failure.message)),
              (evaluation) async {
                // Save the evaluation result
                await saveEvaluationResult(evaluation);
                emit(EvaluationComplete(evaluation: evaluation, question: question));
              },
            );
          },
        );
      },
    );
  }

  /// Load solution history
  Future<void> loadSolutionHistory() async {
    emit(const ProblemSolvingLoading());

    final result = await getSolutionHistory();
    result.fold(
      (failure) => emit(ProblemSolvingError(message: failure.message)),
      (history) => emit(SolutionHistoryLoaded(history: history)),
    );
  }

  /// Store API key
  Future<void> storeApiKeyValue(String apiKey) async {
    emit(const ProblemSolvingLoading());

    final result = await storeApiKey(apiKey);
    result.fold(
      (failure) => emit(ProblemSolvingError(message: failure.message)),
      (_) => emit(const ApiKeyStatus(hasKey: true)),
    );
  }

  /// Check API key status
  Future<void> checkApiKeyStatus() async {
    final result = await hasApiKey();
    result.fold(
      (failure) => emit(const ApiKeyStatus(hasKey: false)),
      (hasKey) => emit(ApiKeyStatus(hasKey: hasKey)),
    );
  }

  /// Update preferred language
  Future<void> updatePreferredLanguage(String language) async {
    final result = await setPreferredLanguage(language);
    result.fold(
      (failure) => emit(ProblemSolvingError(message: failure.message)),
      (_) => emit(LanguagePreferenceUpdated(language: language)),
    );
  }

  /// Reset to initial state
  void reset() {
    emit(const ProblemSolvingInitial());
  }
}
