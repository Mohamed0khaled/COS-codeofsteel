import 'package:flutter/material.dart';
import 'tile_widget.dart';

/// Controller for managing drawer navigation state
class DrawerNavigationController extends ChangeNotifier {
  List<DrawerTile> pages = [
    DrawerTile(
      leadingIcon: const Icon(Icons.home),
      title: () => "Home Page",
      isSelected: true,
    ),
    DrawerTile(
      leadingIcon: const Icon(Icons.calculate),
      title: () => "Problem Solving",
      isSelected: false,
    ),
    DrawerTile(
      leadingIcon: const Icon(Icons.favorite),
      title: () => "Favourites",
      isSelected: false,
    ),
    DrawerTile(
      leadingIcon: const Icon(Icons.save),
      title: () => "Saved",
      isSelected: false,
    ),
    DrawerTile(
      leadingIcon: const Icon(Icons.person),
      title: () => "Profile",
      isSelected: false,
    ),
    DrawerTile(
      leadingIcon: const Icon(Icons.settings),
      title: () => "Settings",
      isSelected: false,
    ),
  ];

  void activate(int index) {
    deactivateAll();
    if (index >= 0 && index < pages.length) {
      pages[index].isSelected = true;
      notifyListeners();
    }
  }

  void deactivateAll() {
    for (int i = 0; i < pages.length; ++i) {
      pages[i].isSelected = false;
    }
    notifyListeners();
  }
}
