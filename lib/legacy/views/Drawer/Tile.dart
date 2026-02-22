import 'package:flutter/material.dart';

class Tile {
  final Icon leading_icon;
  // Changed to a function that returns a String
  final String Function() title; 
  bool state;

  Tile({
    required this.leading_icon, 
    required this.title, 
    this.state = false
  });
}
