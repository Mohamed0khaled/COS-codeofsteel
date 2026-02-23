/// View Layer
/// 
/// Contains all migrated view files from legacy code.
/// Uses Navigator instead of GetX and ProfileCubit instead of UserData.
/// 
/// ## Usage
/// 
/// ```dart
/// import 'package:coursesapp/View/view.dart';
/// 
/// // Navigate to home
/// Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
/// 
/// // Use drawer
/// Scaffold(drawer: const AppDrawerPage(), ...);
/// ```
library view;

// Drawer components
export 'shared/drawer/drawer_page.dart';
export 'shared/drawer/tile_widget.dart';
export 'shared/drawer/drawer_controller.dart';
export 'shared/drawer/drawer_navigation_handler.dart';
export 'shared/drawer/category_widget.dart';

// Shared widgets
export 'shared/widgets/course_card.dart';

// Home
export 'home/home_page.dart';

// Courses
export 'courses/choose_page.dart';
export 'courses/video_page.dart';

// Favourites
export 'favourites/favourites_page.dart';

// Saved
export 'saved/saved_page.dart';

// Problem Solving
export 'problem_solving/problem_solving_page.dart';

// Profile
export 'profile/profile_page.dart';

// Settings
export 'settings/settings_page.dart';
