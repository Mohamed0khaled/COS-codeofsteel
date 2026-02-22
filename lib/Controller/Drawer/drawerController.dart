import 'package:coursesapp/View/Drawer/Tile.dart';
import 'package:flutter/material.dart';

class Drawercontroller extends ChangeNotifier {
  List<Tile> pages = [
    Tile(leading_icon: const Icon(Icons.home), title: () => "Home Page", state: true),
    Tile(
        leading_icon: const Icon(Icons.calculate),
        title: () => "Problem solving",
        state: false),
    Tile(
        leading_icon: const Icon(Icons.favorite),
        title: () => "Favourates",
        state: false),
    Tile(
        leading_icon: const Icon(Icons.save),
        title: () => "Saved",
        state: false),
    Tile(
        leading_icon: const Icon(Icons.person),
        title: () => "Profile",
        state: false),
    Tile(
        leading_icon: const Icon(Icons.settings),
        title: () => "Setting",
        state: false),
  ];

  void activate(int define) {
    disactivate();
    if (define >= 0 && define < pages.length) {
      pages[define].state = true;
      notifyListeners();
    }
  }

  void disactivate() {
    for (int i = 0; i < pages.length; ++i) {
      pages[i].state = false;
    }
    notifyListeners();
  }
}
