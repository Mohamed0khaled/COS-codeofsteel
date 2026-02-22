import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/theme_entity.dart';

/// Base state for Theme
abstract class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object?> get props => [];
}

/// Theme loaded successfully
class ThemeLoaded extends ThemeState {
  final ThemeEntity theme;

  const ThemeLoaded({required this.theme});

  /// Convenience getter for isDarkMode
  bool get isDarkMode => theme.isDarkMode;

  /// Convenience getter for themeMode
  ThemeMode get themeMode => theme.themeMode;

  @override
  List<Object?> get props => [theme];
}

/// Theme error state
class ThemeError extends ThemeState {
  final String message;

  const ThemeError({required this.message});

  @override
  List<Object?> get props => [message];
}
