import 'package:flutter/material.dart';

import 'package:coursesapp/View/home/home_page.dart';

/// Choose course page - migrated from legacy choose.dart
/// Uses Navigator instead of GetX for navigation
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
          children: [
            const SizedBox(height: 10),
            const Text(
              "I want to learn ..",
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
                    _CourseTile(
                      icon: const Icon(Icons.code),
                      title: "C++ Full Course",
                      onTap: () {
                        _navigateToCppCourse(context);
                      },
                    ),
                    _CourseTile(
                      icon: const Icon(Icons.data_object),
                      title: "Python Full Course",
                      onTap: () {
                        // TODO: Navigate to Python course
                      },
                    ),
                    _CourseTile(
                      icon: const Icon(Icons.javascript),
                      title: "JavaScript Full Course",
                      onTap: () {
                        // TODO: Navigate to JavaScript course
                      },
                    ),
                    _CourseTile(
                      icon: const Icon(Icons.flutter_dash),
                      title: "Dart Full Course",
                      onTap: () {
                        // TODO: Navigate to Dart course
                      },
                    ),
                    _CourseTile(
                      icon: const Icon(Icons.phone_android),
                      title: "Flutter Full Tutorials",
                      onTap: () {
                        // TODO: Navigate to Flutter tutorials
                      },
                    ),
                    _CourseTile(
                      icon: const Icon(Icons.web),
                      title: "HTML 5 Full Course",
                      onTap: () {
                        // TODO: Navigate to HTML course
                      },
                    ),
                    _CourseTile(
                      icon: const Icon(Icons.account_tree),
                      title: "Data Structures",
                      onTap: () {
                        // TODO: Navigate to Data Structures course
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => _skipToHomePage(context),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Skip for now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCppCourse(BuildContext context) {
    // TODO: Replace with actual CppPage when migrated
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text("C++ Course Page")),
        ),
      ),
    );
  }

  void _skipToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }
}

/// Course tile widget for the choose page
class _CourseTile extends StatelessWidget {
  const _CourseTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Icon icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 7),
                Text(
                  title,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
            const Icon(Icons.arrow_circle_right),
          ],
        ),
      ),
    );
  }
}
