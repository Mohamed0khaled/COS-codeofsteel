import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:coursesapp/core/network/network_info.dart';

// Auth Feature
import 'package:coursesapp/features/auth/auth.dart';

// User Profile Feature
import 'package:coursesapp/features/user_profile/user_profile.dart';

// Courses Feature
import 'package:coursesapp/features/courses/courses.dart';

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
  // Prevent re-initialization on hot restart
  if (sl.isRegistered<FirebaseAuth>()) {
    return;
  }
  
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
  _initAuthFeature();

  // ----- USER PROFILE FEATURE -----
  _initUserProfileFeature();

  // ----- COURSES FEATURE -----
  _initCoursesFeature();

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

void _initAuthFeature() {
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: GoogleSignIn(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));

  // Cubits - Factory so each widget gets a fresh instance
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      signInWithGoogleUseCase: sl(),
    ),
  );
}

void _initUserProfileFeature() {
  // Data Sources
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(firestore: sl()),
  );

  // Repositories
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUsernameUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileImageUseCase(sl()));
  sl.registerLazySingleton(() => UpdateScoreUseCase(sl()));
  sl.registerLazySingleton(() => CreateUserProfileUseCase(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => ProfileCubit(
      getUserProfileUseCase: sl(),
      updateUsernameUseCase: sl(),
      updateProfileImageUseCase: sl(),
      updateScoreUseCase: sl(),
      createUserProfileUseCase: sl(),
    ),
  );
}

void _initCoursesFeature() {
  // Repositories
  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(firestore: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetCourseDetails(sl()));
  sl.registerLazySingleton(() => GetFavoriteCourses(sl()));
  sl.registerLazySingleton(() => GetSavedCourses(sl()));
  sl.registerLazySingleton(() => GetFinishedCourses(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => ToggleSaved(sl()));
  sl.registerLazySingleton(() => UpdateCourseProgress(sl()));
  sl.registerLazySingleton(() => AddCourse(sl()));
  sl.registerLazySingleton(() => CheckCourseOwnership(sl()));
  sl.registerLazySingleton(() => ApplyDiscountCode(sl()));
  sl.registerLazySingleton(() => PurchaseCourse(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => CoursesCubit(
      getCourseDetails: sl(),
      getFavoriteCourses: sl(),
      getSavedCourses: sl(),
      getFinishedCourses: sl(),
      toggleFavorite: sl(),
      toggleSaved: sl(),
      updateCourseProgress: sl(),
      addCourse: sl(),
      checkCourseOwnership: sl(),
      applyDiscountCode: sl(),
      purchaseCourse: sl(),
    ),
  );
}

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
