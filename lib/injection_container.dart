import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:coursesapp/core/network/network_info.dart';

/// Global service locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
/// 
/// Call this function in main() before runApp()
/// 
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await init();
///   runApp(MyApp());
/// }
/// ```
Future<void> init() async {
  //============================================================
  // EXTERNAL DEPENDENCIES
  //============================================================
  
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  
  // Network
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  
  //============================================================
  // CORE
  //============================================================
  
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<InternetConnectionChecker>()),
  );

  //============================================================
  // FEATURES (to be added during feature migration)
  //============================================================
  
  // ----- AUTH FEATURE -----
  // TODO: Uncomment when auth feature is migrated
  // _initAuthFeature();

  // ----- USER PROFILE FEATURE -----
  // TODO: Uncomment when user profile feature is migrated
  // _initUserProfileFeature();

  // ----- COURSES FEATURE -----
  // TODO: Uncomment when courses feature is migrated
  // _initCoursesFeature();

  // ----- QUIZ FEATURE -----
  // TODO: Uncomment when quiz feature is migrated
  // _initQuizFeature();

  // ----- PROBLEM SOLVING FEATURE -----
  // TODO: Uncomment when problem solving feature is migrated
  // _initProblemSolvingFeature();

  // ----- SETTINGS FEATURE -----
  // TODO: Uncomment when settings feature is migrated
  // _initSettingsFeature();
}

//============================================================
// FEATURE INITIALIZATION TEMPLATES
//============================================================

/// Template for initializing a feature's dependencies.
/// Each feature should have its own initialization function
/// following this pattern:
/// 
/// ```dart
/// void _initAuthFeature() {
///   // Cubits/Blocs
///   sl.registerFactory(() => AuthCubit(
///     signIn: sl(),
///     signUp: sl(),
///     signOut: sl(),
///   ));
/// 
///   // Use Cases
///   sl.registerLazySingleton(() => SignInUseCase(sl()));
///   sl.registerLazySingleton(() => SignUpUseCase(sl()));
///   sl.registerLazySingleton(() => SignOutUseCase(sl()));
/// 
///   // Repositories
///   sl.registerLazySingleton<AuthRepository>(
///     () => AuthRepositoryImpl(
///       remoteDataSource: sl(),
///       localDataSource: sl(),
///       networkInfo: sl(),
///     ),
///   );
/// 
///   // Data Sources
///   sl.registerLazySingleton<AuthRemoteDataSource>(
///     () => AuthRemoteDataSourceImpl(
///       firebaseAuth: sl(),
///       firestore: sl(),
///     ),
///   );
/// 
///   sl.registerLazySingleton<AuthLocalDataSource>(
///     () => AuthLocalDataSourceImpl(
///       sharedPreferences: sl(),
///     ),
///   );
/// }
/// ```

// Placeholder functions - uncomment and implement during feature migration

// void _initAuthFeature() {
//   // Cubits
//   // Use Cases
//   // Repositories
//   // Data Sources
// }

// void _initUserProfileFeature() {
//   // Cubits
//   // Use Cases
//   // Repositories
//   // Data Sources
// }

// void _initCoursesFeature() {
//   // Cubits
//   // Use Cases
//   // Repositories
//   // Data Sources
// }

// void _initQuizFeature() {
//   // Cubits
//   // Use Cases
//   // Repositories
//   // Data Sources
// }

// void _initProblemSolvingFeature() {
//   // Cubits
//   // Use Cases
//   // Repositories
//   // Data Sources
// }

// void _initSettingsFeature() {
//   // Cubits
//   // Use Cases
//   // Repositories
//   // Data Sources
// }
