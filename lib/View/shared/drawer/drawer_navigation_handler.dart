import 'package:flutter/material.dart';

import 'package:coursesapp/View/home/home_page.dart';
import 'package:coursesapp/View/problem_solving/problem_solving_page.dart';
import 'package:coursesapp/View/favourites/favourites_page.dart';
import 'package:coursesapp/View/saved/saved_page.dart';
import 'package:coursesapp/View/profile/profile_page.dart';
import 'package:coursesapp/View/settings/settings_page.dart';

/// Handles drawer tile navigation using Navigator instead of GetX
class DrawerNavigationHandler {
  void handleTileTap(BuildContext context, int id) {
    switch (id) {
      case 1:
        _navigateToHome(context);
        break;
      case 2:
        _navigateToProblemSolving(context);
        break;
      case 3:
        _navigateToFavourites(context);
        break;
      case 4:
        _navigateToSaved(context);
        break;
      case 5:
        _navigateToProfile(context);
        break;
      case 6:
        _navigateToSettings(context);
        break;
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _navigateToProblemSolving(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProblemSolvingPage()),
    );
  }

  void _navigateToFavourites(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FavouritesPage()),
    );
  }

  void _navigateToSaved(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SavedPage()),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }
}
