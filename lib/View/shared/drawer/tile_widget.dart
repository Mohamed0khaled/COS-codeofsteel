import 'package:flutter/material.dart';

/// Drawer tile model for navigation items
class DrawerTile {
  final Icon leadingIcon;
  final String Function() title;
  bool isSelected;

  DrawerTile({
    required this.leadingIcon,
    required this.title,
    this.isSelected = false,
  });
}
