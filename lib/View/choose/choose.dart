import 'package:coursesapp/Courses/cpp/cpp_home.dart';
import 'package:coursesapp/View/choose/elementc.dart';
import 'package:coursesapp/View/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text("Choose Course"),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "I want to learn ..",
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    MoTile(
                      start_icon: const Icon(Icons.alarm_add),
                      title: "C++ Full Course",
                      onclick: () {
                        // Go to cpp course page
                        Get.to(() => const CppPage());
                      },
                    ),
                    MoTile(
                      start_icon: const Icon(Icons.alarm_off),
                      title: "Python Full Course",
                      onclick: () {},
                    ),
                    MoTile(
                      start_icon: const Icon(Icons.cloud_circle),
                      title: "JavaScript Full \nCourse",
                      onclick: () {},
                    ),
                    MoTile(
                      start_icon: const Icon(Icons.car_crash),
                      title: "Dart Full Course",
                      onclick: () {},
                    ),
                    MoTile(
                      start_icon: const Icon(Icons.balance),
                      title: "Flutter Full tutorals",
                      onclick: () {},
                    ),
                    MoTile(
                      start_icon: const Icon(Icons.food_bank),
                      title: "HTML 5 Full Course",
                      onclick: () {},
                    ),
                    MoTile(
                      start_icon:
                          const Icon(Icons.circle_notifications_rounded),
                      title: "Data Structhers",
                      onclick: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Skip for now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                // Go to Home Page
                Get.offAll(() => const HomePage());
              },
            )
          ],
        ),
      ),
    );
  }
}
