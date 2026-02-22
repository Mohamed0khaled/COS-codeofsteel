import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Entity representing app theme configuration
class ThemeEntity extends Equatable {
  final bool isDarkMode;
  final ThemeMode themeMode;

  const ThemeEntity({
    required this.isDarkMode,
    required this.themeMode,
  });

  /// Default theme (light mode)
  factory ThemeEntity.defaults() => const ThemeEntity(
        isDarkMode: false,
        themeMode: ThemeMode.light,
      );

  /// Dark mode theme
  factory ThemeEntity.dark() => const ThemeEntity(
        isDarkMode: true,
        themeMode: ThemeMode.dark,
      );

  /// Light mode theme
  factory ThemeEntity.light() => const ThemeEntity(
        isDarkMode: false,
        themeMode: ThemeMode.light,
      );

  /// Create from isDarkMode boolean
  factory ThemeEntity.fromDarkMode(bool isDarkMode) => ThemeEntity(
        isDarkMode: isDarkMode,
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      );

  /// Copy with method for immutable updates
  ThemeEntity copyWith({
    bool? isDarkMode,
  }) {
    final newIsDarkMode = isDarkMode ?? this.isDarkMode;
    return ThemeEntity(
      isDarkMode: newIsDarkMode,
      themeMode: newIsDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, themeMode];
}
