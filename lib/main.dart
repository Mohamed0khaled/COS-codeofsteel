import 'package:coursesapp/legacy/auth/AuthView/activate.dart';
import 'package:coursesapp/legacy/auth/AuthView/auth.dart';
import 'package:coursesapp/legacy/controllers/Drawer/drawerController.dart';
import 'package:coursesapp/legacy/controllers/fristtime.dart';
import 'package:coursesapp/legacy/controllers/language/languageController.dart';
import 'package:coursesapp/legacy/controllers/theme/theme.dart';
import 'package:coursesapp/legacy/views/homepage.dart';
import 'package:coursesapp/firebase_options.dart';
import 'package:coursesapp/legacy/welcome/welcomeManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

// Clean Architecture imports
import 'package:coursesapp/injection_container.dart' as di;
import 'package:coursesapp/features/auth/auth.dart';
import 'package:coursesapp/features/courses/courses.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
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
  
  // Initialize controllers
  Get.put(ThemeController());
  Get.put(LangController());
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Drawercontroller()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..checkAuthStatus(),
          ),
          BlocProvider<CoursesCubit>(
            create: (_) => di.sl<CoursesCubit>(),
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
    _isFirstTime = await AppOpenChecker.isFirstTime();
    print('✅ App initialization complete');
  }

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    Get.find<LangController>();
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
          // When complete, show the main app with BlocBuilder for auth state
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              // Get userId from auth state for UserIdProvider
              final userId = authState is AuthAuthenticated 
                  ? authState.user.uid 
                  : '';
              
              return UserIdProvider(
                userId: userId,
                child: Obx(() {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: _themeController.themeData,
                    home: _handleUserNav(authState),
                  );
                }),
              );
            },
          );
        }
      },
    );
  }

  // Navigation logic based on first time and auth state from Cubit
  Widget _handleUserNav(AuthState authState) {
    if (_isFirstTime) {
      return WelcomeManagerPage();
    } else if (authState is AuthUnauthenticated || authState is AuthInitial) {
      return const AuthPage();
    } else if (authState is AuthAuthenticated && !authState.user.emailVerified) {
      return ActivatePage();
    } else if (authState is AuthAuthenticated) {
      return const HomePage();
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
