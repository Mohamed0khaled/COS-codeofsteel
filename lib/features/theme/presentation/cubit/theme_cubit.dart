import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/usecases/get_theme.dart';
import '../../domain/usecases/save_theme.dart';
import '../../domain/usecases/toggle_theme.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final GetTheme getTheme;
  final SaveTheme saveTheme;
  final ToggleTheme toggleThemeUseCase;

  ThemeCubit({
    required this.getTheme,
    required this.saveTheme,
    required this.toggleThemeUseCase,
  }) : super(ThemeLoaded(theme: ThemeEntity.defaults()));

  /// Load theme from storage
  void loadTheme() {
    final result = getTheme();
    result.fold(
      (failure) => emit(ThemeError(message: failure.message)),
      (theme) => emit(ThemeLoaded(theme: theme)),
    );
  }

  /// Toggle between dark and light mode
  Future<void> toggleTheme() async {
    final result = await toggleThemeUseCase();
    result.fold(
      (failure) => emit(ThemeError(message: failure.message)),
      (theme) => emit(ThemeLoaded(theme: theme)),
    );
  }

  /// Set specific theme mode
  Future<void> setDarkMode(bool isDarkMode) async {
    final result = await saveTheme(isDarkMode);
    result.fold(
      (failure) => emit(ThemeError(message: failure.message)),
      (_) => emit(ThemeLoaded(theme: ThemeEntity.fromDarkMode(isDarkMode))),
    );
  }
}
