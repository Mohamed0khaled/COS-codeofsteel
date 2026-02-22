/// User Profile Feature
/// 
/// Clean Architecture implementation for user profile management.
/// 
/// ## Usage
/// 
/// ```dart
/// import 'package:coursesapp/features/user_profile/user_profile.dart';
/// 
/// // In widget
/// BlocProvider<ProfileCubit>(
///   create: (_) => sl<ProfileCubit>()..loadProfile(userId),
///   child: ProfilePage(),
/// );
/// 
/// // Access profile state
/// BlocBuilder<ProfileCubit, ProfileState>(
///   builder: (context, state) {
///     if (state is ProfileLoaded) {
///       return Text(state.profile.username);
///     }
///     return CircularProgressIndicator();
///   },
/// );
/// ```
library user_profile;

// Domain
export 'domain/entities/user_profile_entity.dart';
export 'domain/repositories/user_profile_repository.dart';
export 'domain/usecases/get_user_profile_usecase.dart';
export 'domain/usecases/update_username_usecase.dart';
export 'domain/usecases/update_profile_image_usecase.dart';
export 'domain/usecases/update_score_usecase.dart';
export 'domain/usecases/create_user_profile_usecase.dart';

// Data
export 'data/models/user_profile_model.dart';
export 'data/datasources/user_profile_remote_datasource.dart';
export 'data/repositories/user_profile_repository_impl.dart';

// Presentation
export 'presentation/cubit/profile_cubit.dart';
export 'presentation/cubit/profile_state.dart';
