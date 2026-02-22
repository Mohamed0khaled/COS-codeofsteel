// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:coursesapp/Controller/congratulation.dart';
import 'package:coursesapp/Courses/cpp/cppinside.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuizeTemplate extends StatefulWidget {
  QuizeTemplate({super.key,required this.questions});

  List<Map<String, dynamic>> questions;

  @override
  State<QuizeTemplate> createState() => _PdfPageState();
}

class _PdfPageState extends State<QuizeTemplate> {
  final _controller = PageController();
  int _currentIndex = 0;
  final Map<int, int?> _selectedAnswers = {};
  int _score = 0;

  Color getChColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade700
        : Colors.grey.shade300;
  }

  void _calculateScore() {
    _score = 0;
    _selectedAnswers.forEach((index, selectedOption) {
      if (selectedOption == widget.questions[index]['answerIndex']) {
        _score++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Question ${_currentIndex + 1} of ${widget.questions.length}",
              style: const TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.questions.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final question = widget.questions[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        //height: 70,
                        child: Text(
                          question['question'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(question['options'].length,
                          (optionIndex) {
                        final isSelected =
                            _selectedAnswers[index] == optionIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAnswers[index] = optionIndex;
                            });
                          },
                          child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue.shade100
                                    : getChColor(context),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    question['options'][optionIndex],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                    ),
                                  ),
                                  Icon(isSelected
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                      color: Colors.black,)
                                ],
                              )),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: widget.questions.length,
                  effect: const WormEffect(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          if (_currentIndex != widget.questions.length - 1)
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: const Text("Swipe To Next Question ->")),
          if (_currentIndex == widget.questions.length - 1)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    _calculateScore();
                    if (_score > (widget.questions.length * (80 / 100))) {
                      Get.off(() => CongratulationPage(
                            score: _score,
                            question_num: widget.questions.length,
                            next_Page: const CppCoursePage(),
                            course_id: 0000,
                          ));
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        title: 'Try Again',
                        desc:
                            'your score is too low try again \n($_score / ${widget.questions.length})',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  },
                  child: const Text(
                    "Finish",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
