/// Courses feature - Clean Architecture implementation
///
/// This barrel file exports all public APIs for the courses feature.
library courses;

// Domain - Entities
export 'domain/entities/course_entity.dart';

// Domain - Repositories
export 'domain/repositories/course_repository.dart';

// Domain - Use Cases
export 'domain/usecases/add_course.dart';
export 'domain/usecases/apply_discount_code.dart';
export 'domain/usecases/check_course_ownership.dart';
export 'domain/usecases/get_course_details.dart';
export 'domain/usecases/get_favorite_courses.dart';
export 'domain/usecases/get_finished_courses.dart';
export 'domain/usecases/get_saved_courses.dart';
export 'domain/usecases/purchase_course.dart';
export 'domain/usecases/toggle_favorite.dart';
export 'domain/usecases/toggle_saved.dart';
export 'domain/usecases/update_course_progress.dart';

// Data - Models
export 'data/models/course_model.dart';

// Data - Repositories
export 'data/repositories/course_repository_impl.dart';

// Presentation - Cubit
export 'presentation/cubit/courses_cubit.dart';
export 'presentation/cubit/courses_state.dart';
