import 'package:coursesapp/Auth/AuthView/activate.dart';
import 'package:coursesapp/Auth/AuthView/auth.dart';
import 'package:coursesapp/Controller/Drawer/drawerController.dart';
import 'package:coursesapp/Controller/fristtime.dart';
import 'package:coursesapp/Controller/language/languageController.dart';
import 'package:coursesapp/Controller/theme/theme.dart';
import 'package:coursesapp/View/homepage.dart';
import 'package:coursesapp/firebase_options.dart';
import 'package:coursesapp/welcome/welcomeManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // Initialize controllers
  Get.put(ThemeController());
  Get.put(LangController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Drawercontroller()),
      ],
      child: const MyApp(),
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

  // Perform all app initialization tasks
  Future<void> initializeApp() async {
    // Initialize Firebase
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      print('✅ Firebase initialized successfully');
    } catch (e) {
      print('❌ Firebase initialization failed: $e');
    }

    // Check if it's the first time the app is opened
    _isFirstTime = await AppOpenChecker.isFirstTime();

    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle any errors during initialization
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        } else {
          // When complete, show the main app
          return Obx(() {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: _themeController.themeData,
              home: _handleUserNav(),
            );
          });
        }
      },
    );
  }

  // Navigation logic based on first time and user auth state
  Widget _handleUserNav() {
    if (_isFirstTime) {
      return WelcomeManagerPage();
    } else if (FirebaseAuth.instance.currentUser == null) {
      return const AuthPage();
    } else if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      return ActivatePage();
    } else {
      return const HomePage();
    }
  }
}
