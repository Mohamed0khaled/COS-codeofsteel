import 'package:coursesapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// Clean Architecture imports
import 'package:coursesapp/injection_container.dart' as di;
import 'package:coursesapp/features/auth/auth.dart';
import 'package:coursesapp/features/courses/courses.dart';
import 'package:coursesapp/features/quiz/quiz.dart';
import 'package:coursesapp/features/problem_solving/problem_solving.dart';
import 'package:coursesapp/features/settings/settings.dart';
import 'package:coursesapp/features/onboarding/onboarding.dart';
import 'package:coursesapp/features/theme/theme.dart';
import 'package:coursesapp/features/localization/localization.dart';
import 'package:coursesapp/features/user_profile/user_profile.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';
import 'package:coursesapp/core/services/first_time_service.dart';

// Views
import 'package:coursesapp/View/home/home_page.dart';
import 'package:coursesapp/View/shared/drawer/drawer_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase first (required for DI) - safely handle hot restart
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    // Firebase already initialized, ignore
  }
  
  // Initialize dependency injection
  await di.init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrawerNavigationController()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..checkAuthStatus(),
          ),
          BlocProvider<CoursesCubit>(
            create: (_) => di.sl<CoursesCubit>(),
          ),
          BlocProvider<QuizCubit>(
            create: (_) => di.sl<QuizCubit>(),
          ),
          BlocProvider<ProblemSolvingCubit>(
            create: (_) => di.sl<ProblemSolvingCubit>(),
          ),
          BlocProvider<SettingsCubit>(
            create: (_) => di.sl<SettingsCubit>()..loadSettings(),
          ),
          BlocProvider<OnboardingCubit>(
            create: (_) => di.sl<OnboardingCubit>(),
          ),
          BlocProvider<ThemeCubit>(
            create: (_) => di.sl<ThemeCubit>()..loadTheme(),
          ),
          BlocProvider<LocaleCubit>(
            create: (_) => di.sl<LocaleCubit>()..loadLocale(),
          ),
          BlocProvider<ProfileCubit>(
            create: (_) => di.sl<ProfileCubit>(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirstTime = true;
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = initializeApp();
  }

  // Perform remaining app initialization tasks (Firebase already initialized in main)
  Future<void> initializeApp() async {
    // Check if it's the first time the app is opened
    _isFirstTime = await FirstTimeService.isFirstTime();
    print('✅ App initialization complete');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display loading indicator while waiting for initialization
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle any errors during initialization
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        } else {
          // When complete, show the main app with BlocBuilder for auth and theme state
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              // Get userId from auth state for UserIdProvider
              final userId = authState is AuthAuthenticated 
                  ? authState.user.uid 
                  : '';
              
              return UserIdProvider(
                userId: userId,
                child: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    final isDarkMode = themeState is ThemeLoaded 
                        ? themeState.isDarkMode 
                        : false;
                    
                    return BlocBuilder<LocaleCubit, LocaleState>(
                      builder: (context, localeState) {
                        final locale = localeState is LocaleLoaded 
                            ? localeState.locale 
                            : const Locale('en');
                        
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
                          locale: locale,
                          home: _handleUserNav(authState),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  // Navigation logic based on first time and auth state from Cubit
  Widget _handleUserNav(AuthState authState) {
    // Check auth state first - authenticated users go to HomePage
    if (authState is AuthAuthenticated) {
      if (!authState.user.emailVerified) {
        return const ActivatePage();
      }
      return const HomePage();
    }
    
    // For unauthenticated users, check if first time
    if (_isFirstTime) {
      return WelcomeManagerPage();
    } else if (authState is AuthUnauthenticated || authState is AuthInitial) {
      return const AuthPage();
    } else if (authState is AuthLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (authState is AuthError) {
      return const AuthPage(); // On error, show auth page
    } else {
      return const AuthPage(); // Default fallback
    }
  }
}
