import 'package:equatable/equatable.dart';
import 'dart:ui' show Locale;

/// Entity representing app locale/language configuration
class LocaleEntity extends Equatable {
  final String languageCode;
  final bool isRTL;
  final Locale locale;

  const LocaleEntity({
    required this.languageCode,
    required this.isRTL,
    required this.locale,
  });

  /// Default locale (English)
  factory LocaleEntity.defaults() => const LocaleEntity(
        languageCode: 'en',
        isRTL: false,
        locale: Locale('en'),
      );

  /// Arabic locale
  factory LocaleEntity.arabic() => const LocaleEntity(
        languageCode: 'ar',
        isRTL: true,
        locale: Locale('ar'),
      );

  /// English locale
  factory LocaleEntity.english() => const LocaleEntity(
        languageCode: 'en',
        isRTL: false,
        locale: Locale('en'),
      );

  /// Create from language code
  factory LocaleEntity.fromLanguageCode(String languageCode) {
    final isRTL = languageCode == 'ar';
    return LocaleEntity(
      languageCode: languageCode,
      isRTL: isRTL,
      locale: Locale(languageCode),
    );
  }

  /// Check if current locale is Arabic
  bool get isArabic => languageCode == 'ar';

  /// Check if current locale is English
  bool get isEnglish => languageCode == 'en';

  /// Copy with method for immutable updates
  LocaleEntity copyWith({
    String? languageCode,
  }) {
    final newLanguageCode = languageCode ?? this.languageCode;
    return LocaleEntity.fromLanguageCode(newLanguageCode);
  }

  @override
  List<Object?> get props => [languageCode, isRTL, locale];
}
