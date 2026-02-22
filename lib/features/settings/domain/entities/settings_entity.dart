import 'package:equatable/equatable.dart';

/// Entity representing app settings
class SettingsEntity extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final String programmingLanguage;

  const SettingsEntity({
    required this.isDarkMode,
    required this.languageCode,
    required this.programmingLanguage,
  });

  /// Default settings
  factory SettingsEntity.defaults() => const SettingsEntity(
        isDarkMode: false,
        languageCode: 'en',
        programmingLanguage: 'C++',
      );

  /// Copy with method for immutable updates
  SettingsEntity copyWith({
    bool? isDarkMode,
    String? languageCode,
    String? programmingLanguage,
  }) {
    return SettingsEntity(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      programmingLanguage: programmingLanguage ?? this.programmingLanguage,
    );
  }

  /// Check if using Arabic
  bool get isArabic => languageCode == 'ar';

  @override
  List<Object?> get props => [isDarkMode, languageCode, programmingLanguage];
}

/// Available programming languages
class ProgrammingLanguages {
  static const String cpp = 'C++';
  static const String python = 'Python';
  static const String dart = 'Dart';
  static const String java = 'Java';

  static const List<String> all = [cpp, python, dart, java];
}

/// Available app languages
class AppLanguages {
  static const String english = 'en';
  static const String arabic = 'ar';

  static const List<String> all = [english, arabic];

  static String getDisplayName(String code) {
    switch (code) {
      case english:
        return 'English';
      case arabic:
        return 'العربية';
      default:
        return code;
    }
  }
}
