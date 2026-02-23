/// Auth Feature
/// 
/// Clean Architecture implementation for user authentication.
/// 
/// ## Usage
/// 
/// ```dart
/// import 'package:coursesapp/features/auth/auth.dart';
/// 
/// // In widget
/// BlocProvider<AuthCubit>(
///   create: (_) => sl<AuthCubit>()..checkAuthStatus(),
///   child: MyApp(),
/// );
/// 
/// // Access auth state
/// BlocBuilder<AuthCubit, AuthState>(
///   builder: (context, state) {
///     if (state is AuthAuthenticated) {
///       return HomePage();
///     }
///     return AuthPage();
///   },
/// );
/// 
/// // Trigger actions
/// context.read<AuthCubit>().login(email: email, password: password);
/// context.read<AuthCubit>().logout();
/// ```
library auth;

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

// Presentation - Pages
export 'presentation/pages/auth_page.dart';
export 'presentation/pages/signin_page.dart';
export 'presentation/pages/signup_page.dart';
export 'presentation/pages/activate_page.dart';
