import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/code_evaluation_model.dart';

/// Remote data source for AI-based code evaluation.
abstract class QuizRemoteDataSource {
  /// Evaluate code using AI
  Future<CodeEvaluationModel> evaluateCode(String question, String userCode);

  /// Store API key securely
  Future<void> storeApiKey(String apiKey);

  /// Get stored API key
  Future<String?> getApiKey();
}

/// Implementation using Hugging Face API.
class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final http.Client _client;
  final FlutterSecureStorage _secureStorage;

  static const String _apiKeyStorageKey = 'hugging_face_api_key';
  static const String _apiUrl =
      'https://api-inference.huggingface.co/models/Qwen/Qwen2.5-Coder-32B-Instruct';

  QuizRemoteDataSourceImpl({
    http.Client? client,
    FlutterSecureStorage? secureStorage,
  })  : _client = client ?? http.Client(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<CodeEvaluationModel> evaluateCode(
    String question,
    String userCode,
  ) async {
    final apiKey = await getApiKey();

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API Key is not stored');
    }

    final prompt = '''
Evaluate the following answer to the question:

Question: $question

User's Answer:
$userCode

Evaluate the answer based on the following criteria:
- Accuracy (10 points): Does the answer produce the correct output?
- Efficiency (10 points): Is the answer optimized?
- Code Readability (5 points): Is the code well-structured and readable?

Provide only the score and the explanation in this format:
{score: ?, explanation: ?}
Do not include any other information, question, or user answer.
''';

    final response = await _client.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'inputs': prompt,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String result = data[0]['generated_text'];

      return CodeEvaluationModel.fromAiResponse(
        question: question,
        userCode: userCode,
        aiResponse: result,
      );
    } else {
      throw Exception(
          'Failed to evaluate code: ${response.statusCode} - ${response.body}');
    }
  }

  @override
  Future<void> storeApiKey(String apiKey) async {
    await _secureStorage.write(key: _apiKeyStorageKey, value: apiKey);
  }

  @override
  Future<String?> getApiKey() async {
    return await _secureStorage.read(key: _apiKeyStorageKey);
  }
}
