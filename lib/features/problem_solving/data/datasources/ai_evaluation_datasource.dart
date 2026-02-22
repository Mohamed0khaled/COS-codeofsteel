import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/problem_level_entity.dart';
import '../models/evaluation_model.dart';

/// Data source for AI code evaluation using Hugging Face API
abstract class AiEvaluationDataSource {
  /// Evaluate code using AI
  Future<EvaluationModel> evaluateCode({
    required String apiKey,
    required String question,
    required String code,
    required String language,
    required ProblemLevelEntity levelDetails,
    required String solutionId,
  });
}

class AiEvaluationDataSourceImpl implements AiEvaluationDataSource {
  final http.Client client;
  
  static const String _apiUrl = 
      'https://api-inference.huggingface.co/models/Qwen/Qwen2.5-Coder-32B-Instruct';

  AiEvaluationDataSourceImpl({required this.client});

  @override
  Future<EvaluationModel> evaluateCode({
    required String apiKey,
    required String question,
    required String code,
    required String language,
    required ProblemLevelEntity levelDetails,
    required String solutionId,
  }) async {
    try {
      final String prompt = _buildPrompt(
        question: question,
        code: code,
        language: language,
        levelDetails: levelDetails,
      );

      final response = await client.post(
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

        return _parseAiResponse(
          result: result,
          solutionId: solutionId,
          levelDetails: levelDetails,
        );
      } else {
        throw Exception('AI evaluation failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to evaluate code: $e');
    }
  }

  String _buildPrompt({
    required String question,
    required String code,
    required String language,
    required ProblemLevelEntity levelDetails,
  }) {
    return '''
Evaluate the following answer to the question using $language:

Question: $question

User's Answer:
$code

Evaluate the answer based on the following criteria:
- Accuracy (${levelDetails.accuracyScore} points): Does the answer produce the correct output?
- Efficiency (${levelDetails.efficiencyScore} points): Is the answer optimized?
- Code Readability (${levelDetails.readabilityScore} points): Is the code well-structured and readable?

Provide only the score and the explanation in this format:
{score: ?, explanation: ?}
Do not include any other information, question, or user answer.
''';
  }

  EvaluationModel _parseAiResponse({
    required String result,
    required String solutionId,
    required ProblemLevelEntity levelDetails,
  }) {
    // Regex to capture the score and explanation
    final RegExp regex = RegExp(
      r'\{score:\s*(\d+),\s*explanation:\s*(.*?)\}',
      dotAll: true,
    );
    final match = regex.firstMatch(result);

    if (match != null) {
      final int score = int.tryParse(match.group(1)!) ?? 0;
      final String explanation = match.group(2)?.trim() ?? 'No explanation provided';

      return EvaluationModel.fromAiResponse(
        solutionId: solutionId,
        score: score,
        explanation: explanation,
        totalScore: levelDetails.totalScore,
        accuracyScore: levelDetails.accuracyScore,
        efficiencyScore: levelDetails.efficiencyScore,
        readabilityScore: levelDetails.readabilityScore,
      );
    } else {
      // Fallback: Try to extract any meaningful response
      return EvaluationModel.fromAiResponse(
        solutionId: solutionId,
        score: 0,
        explanation: 'Unable to parse AI response. Please try again.',
        totalScore: levelDetails.totalScore,
        accuracyScore: levelDetails.accuracyScore,
        efficiencyScore: levelDetails.efficiencyScore,
        readabilityScore: levelDetails.readabilityScore,
      );
    }
  }
}
