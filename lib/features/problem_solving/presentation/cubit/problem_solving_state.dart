import 'package:equatable/equatable.dart';
import '../../domain/entities/problem_entity.dart';
import '../../domain/entities/problem_level_entity.dart';
import '../../domain/entities/solution_entity.dart';
import '../../domain/entities/evaluation_entity.dart';

/// Base state for Problem Solving
abstract class ProblemSolvingState extends Equatable {
  const ProblemSolvingState();
  
  @override
  List<Object?> get props => [];
}

/// Initial state
class ProblemSolvingInitial extends ProblemSolvingState {
  const ProblemSolvingInitial();
}

/// Loading state
class ProblemSolvingLoading extends ProblemSolvingState {
  const ProblemSolvingLoading();
}

/// Levels loaded state
class LevelsLoaded extends ProblemSolvingState {
  final List<ProblemLevelEntity> levels;
  final String preferredLanguage;

  const LevelsLoaded({
    required this.levels,
    required this.preferredLanguage,
  });

  @override
  List<Object?> get props => [levels, preferredLanguage];
}

/// Problem loaded state - ready to solve
class ProblemLoaded extends ProblemSolvingState {
  final ProblemEntity problem;
  final ProblemLevelEntity levelDetails;
  final String language;

  const ProblemLoaded({
    required this.problem,
    required this.levelDetails,
    required this.language,
  });

  @override
  List<Object?> get props => [problem, levelDetails, language];
}

/// Solution submitted state - waiting for evaluation
class SolutionSubmitted extends ProblemSolvingState {
  final SolutionEntity solution;

  const SolutionSubmitted({required this.solution});

  @override
  List<Object?> get props => [solution];
}

/// Evaluating state - AI is processing
class Evaluating extends ProblemSolvingState {
  const Evaluating();
}

/// Evaluation complete state
class EvaluationComplete extends ProblemSolvingState {
  final EvaluationEntity evaluation;
  final String question;

  const EvaluationComplete({
    required this.evaluation,
    required this.question,
  });

  @override
  List<Object?> get props => [evaluation, question];
}

/// Solution history loaded state
class SolutionHistoryLoaded extends ProblemSolvingState {
  final List<EvaluationEntity> history;

  const SolutionHistoryLoaded({required this.history});

  @override
  List<Object?> get props => [history];
}

/// API key status state
class ApiKeyStatus extends ProblemSolvingState {
  final bool hasKey;

  const ApiKeyStatus({required this.hasKey});

  @override
  List<Object?> get props => [hasKey];
}

/// Language preference updated state
class LanguagePreferenceUpdated extends ProblemSolvingState {
  final String language;

  const LanguagePreferenceUpdated({required this.language});

  @override
  List<Object?> get props => [language];
}

/// Error state
class ProblemSolvingError extends ProblemSolvingState {
  final String message;

  const ProblemSolvingError({required this.message});

  @override
  List<Object?> get props => [message];
}
