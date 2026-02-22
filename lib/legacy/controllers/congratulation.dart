import 'package:coursesapp/legacy/auth/AuthController/userdatacontroller.dart';
import 'package:coursesapp/legacy/controllers/course_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationPage extends StatefulWidget {
  CongratulationPage(
      {super.key,
      required this.score,
      required this.question_num,
      required this.course_id,
      required this.next_Page});

  int score;
  int question_num;
  int course_id;
  final Widget next_Page;

  @override
  State<CongratulationPage> createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage> {
  final UserData _userData = UserData();
  final CourseService _courseService = CourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "images/star.png",
                  scale: 1.7,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Congratulations!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "You've just get score ${widget.score} / ${widget.question_num}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Proceed To The Next Lesson",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            onTap: () async {
              int old_score = await _userData.getScore();
              await _userData.updateScore(old_score + widget.score);
              String user_id = _userData.getUserId();
              int prog = await _courseService.getCourseProgress(
                  user_id, widget.course_id);
              if (prog > 2) {
                _courseService.updateProgress(user_id, widget.course_id, prog);
              } else {
                print("The Progress is actualy $prog");
              }
              Get.offAll(() => widget.next_Page);
            },
          )
        ],
      ),
    );
  }
}
