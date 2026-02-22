import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/locale_entity.dart';

/// Local data source for Locale
abstract class LocaleLocalDataSource {
  /// Get current locale setting
  LocaleEntity getLocale();

  /// Save locale setting
  Future<void> saveLocale(String languageCode);

  /// Toggle and save locale
  Future<LocaleEntity> toggleLocale();
}

class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _localeKey = 'langCode';
  static const String _defaultLanguage = 'en';

  LocaleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  LocaleEntity getLocale() {
    final languageCode = sharedPreferences.getString(_localeKey) ?? _defaultLanguage;
    return LocaleEntity.fromLanguageCode(languageCode);
  }

  @override
  Future<void> saveLocale(String languageCode) async {
    await sharedPreferences.setString(_localeKey, languageCode);
  }

  @override
  Future<LocaleEntity> toggleLocale() async {
    final currentLocale = getLocale();
    final newLanguageCode = currentLocale.isArabic ? 'en' : 'ar';
    await saveLocale(newLanguageCode);
    return LocaleEntity.fromLanguageCode(newLanguageCode);
  }
}
