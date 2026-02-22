import 'package:equatable/equatable.dart';
import '../../domain/entities/settings_entity.dart';

/// Base state for Settings
abstract class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object?> get props => [];
}

/// Initial state
class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

/// Loading state
class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

/// Settings loaded successfully
class SettingsLoaded extends SettingsState {
  final SettingsEntity settings;

  const SettingsLoaded({required this.settings});

  @override
  List<Object?> get props => [settings];
}

/// Dark mode updated
class DarkModeUpdated extends SettingsState {
  final bool isDarkMode;

  const DarkModeUpdated({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];
}

/// Language updated
class LanguageUpdated extends SettingsState {
  final String languageCode;

  const LanguageUpdated({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];
}

/// Programming language updated
class ProgrammingLanguageUpdated extends SettingsState {
  final String language;

  const ProgrammingLanguageUpdated({required this.language});

  @override
  List<Object?> get props => [language];
}

/// First launch check result
class FirstLaunchStatus extends SettingsState {
  final bool isFirstLaunch;

  const FirstLaunchStatus({required this.isFirstLaunch});

  @override
  List<Object?> get props => [isFirstLaunch];
}

/// Error state
class SettingsError extends SettingsState {
  final String message;

  const SettingsError({required this.message});

  @override
  List<Object?> get props => [message];
}
