import 'dart:convert';
import 'package:coursesapp/Auth/AuthController/userdatacontroller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CheckProblemPage extends StatefulWidget {
  CheckProblemPage({
    super.key,
    required this.userAnswer,
    required this.question,
    required this.level,
  });
  String userAnswer;
  String question;
  int level;

  @override
  _CheckProblemPageState createState() => _CheckProblemPageState();
}

class _CheckProblemPageState extends State<CheckProblemPage> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  UserData _userData = UserData();
  // Variables
  int? score; // Variable to store the score
  bool isLoading = false; // Loading state
  String finalResult = "";
  int finalScore = 0;
  late int total_score;
  late int Accuracy_score;
  late int Efficiency_score;
  late int Readability_score;
  String? user_pspl;

  Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;
  }

  void CalcScore() {
    if (widget.level == 0) {
      total_score = 5;
      Accuracy_score = 2;
      Efficiency_score = 2;
      Readability_score = 1;
    } else if (widget.level == 1) {
      total_score = 7;
      Accuracy_score = 3;
      Efficiency_score = 3;
      Readability_score = 1;
    } else if (widget.level == 2) {
      total_score = 10;
      Accuracy_score = 4;
      Efficiency_score = 4;
      Readability_score = 2;
    } else if (widget.level == 3) {
      total_score = 15;
      Accuracy_score = 6;
      Efficiency_score = 6;
      Readability_score = 3;
    } else if (widget.level == 4) {
      total_score = 30;
      Accuracy_score = 14;
      Efficiency_score = 14;
      Readability_score = 2;
    } else if (widget.level == 5) {
      total_score = 50;
      Accuracy_score = 22;
      Efficiency_score = 22;
      Readability_score = 6;
    } else if (widget.level == 6) {
      total_score = 70;
      Accuracy_score = 30;
      Efficiency_score = 30;
      Readability_score = 10;
    }
  }

  Future<void> GetPSPL() async {
    user_pspl = await _userData.getUserpspl();
  }

  // Store the Hugging Face API Key
  // TODO: Move API key to environment variables before production
  static const String _apiKeyStorageKey = 'hugging_face_api_key';
  
  Future<void> storeApiKey(String apiKey) async {
    await secureStorage.write(key: _apiKeyStorageKey, value: apiKey);
    print("Hugging Face API key stored securely.");
  }

  // Retrieve the Hugging Face API Key
  Future<String?> getApiKey() async {
    return await secureStorage.read(key: _apiKeyStorageKey);
  }

  // Function to check the answer using CodeGen
  Future<void> checkAnswer() async {
    setState(() {
      isLoading = true;
    });

    final apiKey = await getApiKey();

    if (apiKey == null) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("API Key is not stored!"),
      ));
      return;
    }

    // CodeGen API URL (replace with actual CodeGen model endpoint)
    const apiUrl =
        'https://api-inference.huggingface.co/models/Qwen/Qwen2.5-Coder-32B-Instruct';

    // Create a prompt to evaluate the user's code answer
    String prompt = """
Evaluate the following answer to the question using ${user_pspl}:

Question: ${widget.question}

User's Answer:
${widget.userAnswer}

Evaluate the answer based on the following criteria:
- Accuracy (${Accuracy_score} points): Does the answer produce the correct output?
- Efficiency (${Efficiency_score} points): Is the answer optimized?
- Code Readability (${Readability_score} points): Is the code well-structured and readable?

Provide only the score and the explanation in this format:
{score: ?, explanation: ?}
Do not include any other information, question, or user answer.
""";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "inputs": prompt,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String result = data[0]['generated_text'];

        // Regex to capture the score and explanation in the required format
        final RegExp regex =
            RegExp(r"\{score:\s*(\d+),\s*explanation:\s*(.*?)\}", dotAll: true);
        final match = regex.firstMatch(result);

        if (match != null) {
          setState(() {
            finalScore = int.tryParse(match.group(1)!) ?? 0; // Extract score
            finalResult = match.group(2)!; // Extract explanation
            score = finalScore;
            isLoading = false;
            print(finalResult);
          });
        } else {
          throw Exception("Score and explanation not found in response");
        }
      } else {
        throw Exception(
            'Failed to fetch response: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Try Again Later")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    CalcScore(); // Ensure scores are calculated before using them
    GetPSPL();
    // TODO: Load API key from environment variable
    // storeApiKey(const String.fromEnvironment('HF_API_KEY'));
    checkAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check Answer")),
      body: isLoading
          ? const Center(
              child: SizedBox(
                width: 90,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [Colors.blue, Colors.red, Colors.green],
                  strokeWidth: 2,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          "Question: ${widget.question}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            height: 230,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: getCardColor(context),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Your Score",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 13.0,
                                  percent: finalScore / total_score,
                                  progressColor: Colors.blue,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  animation: true,
                                  animationDuration: 1000,
                                  center: Text(
                                    "$finalScore",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          "The Evaluation:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            finalResult,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add the score to the profile and back to the problem solving page
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Finish",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
