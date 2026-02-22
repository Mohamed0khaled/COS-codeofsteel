import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/problem_level_entity.dart';
import '../models/problem_level_model.dart';

/// Local data source for Problem Solving - handles secure storage and preferences
abstract class ProblemSolvingLocalDataSource {
  /// Store API key securely
  Future<void> storeApiKey(String apiKey);

  /// Get stored API key
  Future<String?> getApiKey();

  /// Check if API key is stored
  Future<bool> hasApiKey();

  /// Get all difficulty levels
  List<ProblemLevelModel> getAllLevels();

  /// Get level details by level number
  ProblemLevelModel getLevelDetails(int level);

  /// Get user's preferred programming language
  Future<String> getPreferredLanguage();

  /// Set user's preferred programming language
  Future<void> setPreferredLanguage(String language);
}

class ProblemSolvingLocalDataSourceImpl implements ProblemSolvingLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  static const String _apiKeyStorageKey = 'hugging_face_api_key';
  static const String _preferredLanguageKey = 'problem_solving_language';
  static const String _defaultLanguage = 'cpp';

  ProblemSolvingLocalDataSourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<void> storeApiKey(String apiKey) async {
    await secureStorage.write(key: _apiKeyStorageKey, value: apiKey);
  }

  @override
  Future<String?> getApiKey() async {
    return await secureStorage.read(key: _apiKeyStorageKey);
  }

  @override
  Future<bool> hasApiKey() async {
    final apiKey = await getApiKey();
    return apiKey != null && apiKey.isNotEmpty;
  }

  @override
  List<ProblemLevelModel> getAllLevels() {
    return ProblemLevelEntity.getAllLevels()
        .map((e) => ProblemLevelModel.fromEntity(e))
        .toList();
  }

  @override
  ProblemLevelModel getLevelDetails(int level) {
    return ProblemLevelModel.fromEntity(ProblemLevelEntity.getByLevel(level));
  }

  @override
  Future<String> getPreferredLanguage() async {
    return sharedPreferences.getString(_preferredLanguageKey) ?? _defaultLanguage;
  }

  @override
  Future<void> setPreferredLanguage(String language) async {
    await sharedPreferences.setString(_preferredLanguageKey, language);
  }
}

/// Available programming languages for problem solving
class SupportedLanguages {
  static const String cpp = 'cpp';
  static const String python = 'python';
  static const String java = 'java';
  static const String dart = 'dart';

  static const List<String> all = [cpp, python, java, dart];

  static String getDisplayName(String language) {
    switch (language) {
      case cpp:
        return 'C++';
      case python:
        return 'Python';
      case java:
        return 'Java';
      case dart:
        return 'Dart';
      default:
        return language.toUpperCase();
    }
  }
}
