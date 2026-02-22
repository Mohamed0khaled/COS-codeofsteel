import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/theme_entity.dart';

/// Local data source for Theme
abstract class ThemeLocalDataSource {
  /// Get current theme setting
  ThemeEntity getTheme();

  /// Save theme setting
  Future<void> saveTheme(bool isDarkMode);

  /// Toggle and save theme
  Future<ThemeEntity> toggleTheme();
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _themeKey = 'isDarkMode';

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  ThemeEntity getTheme() {
    final isDarkMode = sharedPreferences.getBool(_themeKey) ?? false;
    return ThemeEntity.fromDarkMode(isDarkMode);
  }

  @override
  Future<void> saveTheme(bool isDarkMode) async {
    await sharedPreferences.setBool(_themeKey, isDarkMode);
  }

  @override
  Future<ThemeEntity> toggleTheme() async {
    final currentTheme = getTheme();
    final newIsDarkMode = !currentTheme.isDarkMode;
    await saveTheme(newIsDarkMode);
    return ThemeEntity.fromDarkMode(newIsDarkMode);
  }
}
