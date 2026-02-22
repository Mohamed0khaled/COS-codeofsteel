// Domain - Entities
export 'domain/entities/problem_entity.dart';
export 'domain/entities/problem_level_entity.dart';
export 'domain/entities/solution_entity.dart';
export 'domain/entities/evaluation_entity.dart';

// Domain - Repository
export 'domain/repositories/problem_solving_repository.dart';

// Domain - Use Cases
export 'domain/usecases/get_random_problem.dart';
export 'domain/usecases/get_all_levels.dart';
export 'domain/usecases/get_level_details.dart';
export 'domain/usecases/submit_solution.dart';
export 'domain/usecases/evaluate_solution.dart';
export 'domain/usecases/save_evaluation_result.dart';
export 'domain/usecases/get_solution_history.dart';
export 'domain/usecases/store_api_key.dart';
export 'domain/usecases/has_api_key.dart';
export 'domain/usecases/get_preferred_language.dart';
export 'domain/usecases/set_preferred_language.dart';

// Data - Models
export 'data/models/problem_model.dart';
export 'data/models/problem_level_model.dart';
export 'data/models/solution_model.dart';
export 'data/models/evaluation_model.dart';

// Data - Data Sources
export 'data/datasources/problem_solving_remote_datasource.dart';
export 'data/datasources/problem_solving_local_datasource.dart';
export 'data/datasources/ai_evaluation_datasource.dart';

// Data - Repository Implementation
export 'data/repositories/problem_solving_repository_impl.dart';

// Presentation - Cubit
export 'presentation/cubit/problem_solving_cubit.dart';
export 'presentation/cubit/problem_solving_state.dart';
