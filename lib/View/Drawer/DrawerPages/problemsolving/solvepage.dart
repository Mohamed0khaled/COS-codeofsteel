import 'package:coursesapp/Controller/course_class.dart';
import 'package:coursesapp/Model/PS_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/dart.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SolvePage extends StatefulWidget {
  SolvePage({
    super.key,
    required this.Level,
    required this.Language_chars,
  });

  final int Level;
  final String Language_chars;

  @override
  State<SolvePage> createState() => _SolvePageState();
}

class _SolvePageState extends State<SolvePage> {
  // Classes Call
  final CourseService _courseService = CourseService();

  // Variables
  bool isLoading = true; // Use camelCase for naming variables
  String problem = "";

  Mode getLanguageMode(String language) {
    // Map of languages and their respective modes
    final Map<String, Mode> languageModes = {
      'cpp': cpp,
      'python': python,
      'java': java,
      'dart': dart,
    };

    // Return the corresponding mode or throw an error if not found
    if (languageModes.containsKey(language)) {
      return languageModes[language]!;
    } else {
      throw ArgumentError('Unsupported language: $language');
    }
  }

  late final CodeController _codeController = CodeController(
    language: getLanguageMode(widget.Language_chars),
  );

  @override
  void dispose() {
    // Dispose of the controller when not in use
    _codeController.dispose();
    super.dispose();
  }

  final List<String> _keys = [
    '#',
    '<',
    '>',
    '{',
    '}',
    '[',
    ']',
    '*',
    '&',
    ';',
    '(',
    ')',
  ];

  void onKeyPressed(String key) {
    setState(() {
      _codeController.text += key;
    });
  }

  Future<void> getProblem() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch the problem, handle possible null
      String? fetchedProblem =
          await _courseService.getRandomQuestion(widget.Level);

      if (fetchedProblem != null) {
        print('Fetched problem: $fetchedProblem'); // Debugging line
        problem = fetchedProblem; // Assign only if it's not null
      } else {
        print('No problem found for this level.');
        problem = "No question available for this level.";
      }
    } catch (e) {
      problem = "Failed to load problem: $e";
      print('Error occurred: $e'); // More detailed error logging
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _codeController.popupController.enabled = false;
    getProblem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Page"),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: TimerCountdown(
              format: CountDownTimerFormat.minutesSeconds,
              enableDescriptions: false,
              timeTextStyle: const TextStyle(color: Colors.white),
              colonsTextStyle: const TextStyle(color: Colors.white),
              endTime: DateTime.now().add(
                const Duration(minutes: 30),
              ),
            ),
          )
        ],
      ),
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
          : Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Question",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              problem,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Write your code below:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              child: CodeTheme(
                                data:
                                    CodeThemeData(styles: monokaiSublimeTheme),
                                child: SingleChildScrollView(
                                  child: CodeField(
                                    controller: _codeController,
                                    minLines: 10,
                                    textStyle: const TextStyle(fontSize: 15),
                                    gutterStyle: const GutterStyle(
                                      width: 70,
                                      margin: 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to API Page
                        Get.to(() => CheckProblemPage(
                          userAnswer: _codeController.text, 
                          question: problem, 
                          level: widget.Level, 
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 15),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        child: const Text(
                          "Finish",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  right: 5,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First row of custom keyboard
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _keys.sublist(0, 6).map((key) {
                            return Expanded(
                              child: TextButton(
                                onPressed: () {
                                  onKeyPressed(key);
                                },
                                child: Text(
                                  key,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        // Second row of custom keyboard
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _keys.sublist(6).map((key) {
                            return Expanded(
                              child: TextButton(
                                onPressed: () {
                                  onKeyPressed(key);
                                },
                                child: Text(
                                  key,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
