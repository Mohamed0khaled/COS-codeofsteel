import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/set_dark_mode.dart';
import '../../domain/usecases/set_language.dart';
import '../../domain/usecases/set_programming_language.dart';
import '../../domain/usecases/is_first_launch.dart';
import '../../domain/usecases/complete_first_launch.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettings getSettings;
  final SetDarkMode setDarkMode;
  final SetLanguage setLanguage;
  final SetProgrammingLanguage setProgrammingLanguage;
  final IsFirstLaunch isFirstLaunch;
  final CompleteFirstLaunch completeFirstLaunch;

  // Cache the current settings
  SettingsEntity? _currentSettings;

  SettingsCubit({
    required this.getSettings,
    required this.setDarkMode,
    required this.setLanguage,
    required this.setProgrammingLanguage,
    required this.isFirstLaunch,
    required this.completeFirstLaunch,
  }) : super(const SettingsInitial());

  /// Get current cached settings
  SettingsEntity? get currentSettings => _currentSettings;

  /// Load all settings
  Future<void> loadSettings() async {
    emit(const SettingsLoading());

    final result = await getSettings();
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (settings) {
        _currentSettings = settings;
        emit(SettingsLoaded(settings: settings));
      },
    );
  }

  /// Toggle dark mode
  Future<void> toggleDarkMode(bool isDarkMode) async {
    final result = await setDarkMode(isDarkMode);
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (_) {
        _currentSettings = _currentSettings?.copyWith(isDarkMode: isDarkMode);
        emit(DarkModeUpdated(isDarkMode: isDarkMode));
      },
    );
  }

  /// Update app language
  Future<void> updateLanguage(String languageCode) async {
    final result = await setLanguage(languageCode);
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (_) {
        _currentSettings = _currentSettings?.copyWith(languageCode: languageCode);
        emit(LanguageUpdated(languageCode: languageCode));
      },
    );
  }

  /// Update programming language preference
  Future<void> updateProgrammingLanguage(String language) async {
    final result = await setProgrammingLanguage(language);
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (_) {
        _currentSettings = _currentSettings?.copyWith(programmingLanguage: language);
        emit(ProgrammingLanguageUpdated(language: language));
      },
    );
  }

  /// Check if this is first app launch
  Future<void> checkFirstLaunch() async {
    final result = await isFirstLaunch();
    result.fold(
      (failure) => emit(const FirstLaunchStatus(isFirstLaunch: false)),
      (isFirst) => emit(FirstLaunchStatus(isFirstLaunch: isFirst)),
    );
  }

  /// Mark onboarding as complete
  Future<void> finishOnboarding() async {
    final result = await completeFirstLaunch();
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (_) => emit(const FirstLaunchStatus(isFirstLaunch: false)),
    );
  }
}
