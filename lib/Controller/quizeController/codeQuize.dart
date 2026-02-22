// ignore_for_file: depend_on_referenced_packages

import 'package:coursesapp/Model/quize_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CodeQuizePage extends StatefulWidget {
  CodeQuizePage({super.key, required this.question});
  String question;

  @override
  State<CodeQuizePage> createState() => _CodeQuizePageState();
}

class _CodeQuizePageState extends State<CodeQuizePage> {
  // Create a controller for the code editor
  late final CodeController _codeController = CodeController(
    language: cpp,
  );

  @override
  void dispose() {
    // Dispose of the controller when not in use
    _codeController.dispose();
    super.dispose();
  }

  void _onFinishPressed() {
    // Handle the finish button press
    // You can perform any action like submitting the answer here
    print('Finish button pressed');
  }

  // ignore: unused_field
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
    ')'
  ];
  void onkeyPressed(String key) {
    setState(() {
      _codeController.text += key;
    });
  }

  @override
  void initState() {
    super.initState();
    _codeController.popupController.enabled = false;
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
                const Duration(minutes: 15),
              ),
              onEnd: () {
                Get.to(() => CheckAnswerPage(
                    userAnswer: _codeController.text,
                    question: widget.question));
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Question is:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.question,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            20), // Spacer between the question and code editor
                    const Text(
                      "Write your code below:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    // Code editor widget here
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        child: CodeTheme(
                          data: CodeThemeData(styles: monokaiSublimeTheme),
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
                  // Go to ai Page
                  Get.to(() => CheckAnswerPage(
                      userAnswer: _codeController.text,
                      question: widget.question));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
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
              SizedBox(
                height: 100,
              )
            ],
          ),
          // Positioned widget to place the "Finish" button at the bottom
          Positioned(
            bottom: 5,
            left: 5, 
            right: 5, 
            child: GestureDetector(
                onTap: _onFinishPressed, 
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // الصف الأول
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // المركز
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('#');
                              },
                              child: const Text(
                                "#",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('<');
                              },
                              child: const Text(
                                "<",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('>');
                              },
                              child: const Text(
                                ">",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('{');
                              },
                              child: const Text(
                                "{",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('}');
                              },
                              child: const Text(
                                "}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('(');
                              },
                              child: const Text(
                                "(",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // الصف الثاني
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // المركز
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('[');
                              },
                              child: const Text(
                                "[",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed(']');
                              },
                              child: const Text(
                                "]",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('*');
                              },
                              child: const Text(
                                "*",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed('&');
                              },
                              child: const Text(
                                "&",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed(';');
                              },
                              child: const Text(
                                ";",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                onkeyPressed(')');
                              },
                              child: const Text(
                                ")",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),

          
        ],
      ),
    );
  }
}
