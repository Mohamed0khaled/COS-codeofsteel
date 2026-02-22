import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:coursesapp/core/network/network_info.dart';

// Auth Feature
import 'package:coursesapp/features/auth/auth.dart';

// User Profile Feature
import 'package:coursesapp/features/user_profile/user_profile.dart';

// Courses Feature
import 'package:coursesapp/features/courses/courses.dart';

// Quiz Feature
import 'package:coursesapp/features/quiz/quiz.dart';

// Problem Solving Feature
import 'package:coursesapp/features/problem_solving/problem_solving.dart';

// Settings Feature
import 'package:coursesapp/features/settings/settings.dart';

// Onboarding Feature
import 'package:coursesapp/features/onboarding/onboarding.dart';

// Theme Feature
import 'package:coursesapp/features/theme/theme.dart';

// Localization Feature
import 'package:coursesapp/features/localization/localization.dart';

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
  
  // Secure Storage
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  
  // HTTP Client
  sl.registerLazySingleton<http.Client>(() => http.Client());
  
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
  _initQuizFeature();

  // ----- PROBLEM SOLVING FEATURE -----
  _initProblemSolvingFeature();

  // ----- SETTINGS FEATURE -----
  _initSettingsFeature();

  // ----- ONBOARDING FEATURE -----
  _initOnboardingFeature();

  // ----- THEME FEATURE -----
  _initThemeFeature();

  // ----- LOCALIZATION FEATURE -----
  _initLocalizationFeature();
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

void _initQuizFeature() {
  // Data Sources
  sl.registerLazySingleton<QuizLocalDataSource>(
    () => QuizLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      firestore: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetQuizById(sl()));
  sl.registerLazySingleton(() => GetQuizzesByCourse(sl()));
  sl.registerLazySingleton(() => SubmitQuiz(sl()));
  sl.registerLazySingleton(() => SaveQuizResult(sl()));
  sl.registerLazySingleton(() => GetQuizHistory(sl()));
  sl.registerLazySingleton(() => EvaluateCode(sl()));
  sl.registerLazySingleton(() => StoreApiKey(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => QuizCubit(
      getQuizById: sl(),
      getQuizzesByCourse: sl(),
      submitQuiz: sl(),
      saveQuizResult: sl(),
      getQuizHistory: sl(),
      evaluateCode: sl(),
      storeApiKey: sl(),
    ),
  );
}

void _initProblemSolvingFeature() {
  // Data Sources
  sl.registerLazySingleton<ProblemSolvingRemoteDataSource>(
    () => ProblemSolvingRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ProblemSolvingLocalDataSource>(
    () => ProblemSolvingLocalDataSourceImpl(
      secureStorage: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<AiEvaluationDataSource>(
    () => AiEvaluationDataSourceImpl(client: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ProblemSolvingRepository>(
    () => ProblemSolvingRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      aiDataSource: sl(),
      firebaseAuth: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetRandomProblem(sl()));
  sl.registerLazySingleton(() => GetAllLevels(sl()));
  sl.registerLazySingleton(() => GetLevelDetails(sl()));
  sl.registerLazySingleton(() => SubmitSolution(sl()));
  sl.registerLazySingleton(() => EvaluateSolution(sl()));
  sl.registerLazySingleton(() => SaveEvaluationResult(sl()));
  sl.registerLazySingleton(() => GetSolutionHistory(sl()));
  sl.registerLazySingleton(() => StoreProblemSolvingApiKey(sl()));
  sl.registerLazySingleton(() => HasApiKey(sl()));
  sl.registerLazySingleton(() => GetPreferredLanguage(sl()));
  sl.registerLazySingleton(() => SetPreferredLanguage(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => ProblemSolvingCubit(
      getRandomProblem: sl(),
      getAllLevels: sl(),
      getLevelDetails: sl(),
      submitSolution: sl(),
      evaluateSolution: sl(),
      saveEvaluationResult: sl(),
      getSolutionHistory: sl(),
      storeApiKey: sl(),
      hasApiKey: sl(),
      getPreferredLanguage: sl(),
      setPreferredLanguage: sl(),
    ),
  );
}

void _initSettingsFeature() {
  // Data Sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImpl(firestore: sl()),
  );

  // Repositories
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      firebaseAuth: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => SetDarkMode(sl()));
  sl.registerLazySingleton(() => SetLanguage(sl()));
  sl.registerLazySingleton(() => SetProgrammingLanguage(sl()));
  sl.registerLazySingleton(() => IsFirstLaunch(sl()));
  sl.registerLazySingleton(() => CompleteFirstLaunch(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => SettingsCubit(
      getSettings: sl(),
      setDarkMode: sl(),
      setLanguage: sl(),
      setProgrammingLanguage: sl(),
      isFirstLaunch: sl(),
      completeFirstLaunch: sl(),
    ),
  );
}

void _initOnboardingFeature() {
  // Data Sources
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetOnboardingPages(sl()));
  sl.registerLazySingleton(() => IsOnboardingCompleted(sl()));
  sl.registerLazySingleton(() => CompleteOnboarding(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => OnboardingCubit(
      getOnboardingPages: sl(),
      isOnboardingCompleted: sl(),
      completeOnboarding: sl(),
    ),
  );
}

void _initThemeFeature() {
  // Data Sources
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetTheme(sl()));
  sl.registerLazySingleton(() => SaveTheme(sl()));
  sl.registerLazySingleton(() => ToggleTheme(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => ThemeCubit(
      getTheme: sl(),
      saveTheme: sl(),
      toggleThemeUseCase: sl(),
    ),
  );
}

void _initLocalizationFeature() {
  // Data Sources
  sl.registerLazySingleton<LocaleLocalDataSource>(
    () => LocaleLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<LocaleRepository>(
    () => LocaleRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetLocale(sl()));
  sl.registerLazySingleton(() => SaveLocale(sl()));
  sl.registerLazySingleton(() => ToggleLocale(sl()));

  // Cubits - Factory so each screen gets a fresh instance
  sl.registerFactory(
    () => LocaleCubit(
      getLocale: sl(),
      saveLocale: sl(),
      toggleLocaleUseCase: sl(),
    ),
  );
}
