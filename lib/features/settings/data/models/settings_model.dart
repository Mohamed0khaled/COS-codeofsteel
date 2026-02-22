import '../../domain/entities/settings_entity.dart';

/// Model for Settings with JSON serialization
class SettingsModel extends SettingsEntity {
  const SettingsModel({
    required super.isDarkMode,
    required super.languageCode,
    required super.programmingLanguage,
  });

  /// Create from JSON map
  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      languageCode: json['languageCode'] as String? ?? 'en',
      programmingLanguage: json['programmingLanguage'] as String? ?? 'C++',
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'programmingLanguage': programmingLanguage,
    };
  }

  /// Create from entity
  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      isDarkMode: entity.isDarkMode,
      languageCode: entity.languageCode,
      programmingLanguage: entity.programmingLanguage,
    );
  }

  /// Create default model
  factory SettingsModel.defaults() => const SettingsModel(
        isDarkMode: false,
        languageCode: 'en',
        programmingLanguage: 'C++',
      );
}
