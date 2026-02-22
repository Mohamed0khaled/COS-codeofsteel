/// Quiz feature - Clean Architecture implementation
///
/// This barrel file exports all public APIs for the quiz feature.
library quiz;

// Domain - Entities
export 'domain/entities/question_entity.dart';
export 'domain/entities/quiz_entity.dart';
export 'domain/entities/quiz_result_entity.dart';
export 'domain/entities/code_evaluation_entity.dart';

// Domain - Repositories
export 'domain/repositories/quiz_repository.dart';

// Domain - Use Cases
export 'domain/usecases/get_quiz_by_id.dart';
export 'domain/usecases/get_quizzes_by_course.dart';
export 'domain/usecases/submit_quiz.dart';
export 'domain/usecases/save_quiz_result.dart';
export 'domain/usecases/get_quiz_history.dart';
export 'domain/usecases/evaluate_code.dart';
export 'domain/usecases/store_api_key.dart';

// Data - Models
export 'data/models/question_model.dart';
export 'data/models/quiz_model.dart';
export 'data/models/quiz_result_model.dart';
export 'data/models/code_evaluation_model.dart';

// Data - Data Sources
export 'data/datasources/quiz_local_datasource.dart';
export 'data/datasources/quiz_remote_datasource.dart';

// Data - Repositories
export 'data/repositories/quiz_repository_impl.dart';

// Presentation - Cubit
export 'presentation/cubit/quiz_cubit.dart';
export 'presentation/cubit/quiz_state.dart';
