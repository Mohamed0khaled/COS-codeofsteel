// Auth Feature Barrel Export
//
// This file exports all public auth feature classes.
// Import this file to access auth functionality.

// Domain - Entities
export 'domain/entities/user_entity.dart';

// Domain - Repositories (interface)
export 'domain/repositories/auth_repository.dart';

// Domain - Use Cases
export 'domain/usecases/login_usecase.dart';
export 'domain/usecases/register_usecase.dart';
export 'domain/usecases/logout_usecase.dart';
export 'domain/usecases/get_current_user_usecase.dart';
export 'domain/usecases/sign_in_with_google_usecase.dart';

// Data - Models
export 'data/models/user_model.dart';

// Data - Data Sources
export 'data/datasources/auth_remote_datasource.dart';

// Data - Repositories (implementation)
export 'data/repositories/auth_repository_impl.dart';

// Presentation - Cubit
export 'presentation/cubit/auth_cubit.dart';
export 'presentation/cubit/auth_state.dart';
