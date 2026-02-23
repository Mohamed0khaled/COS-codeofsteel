import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:coursesapp/features/auth/presentation/pages/auth_page.dart';

class WelcomeManagerPage extends StatelessWidget {
  final _controller = PageController();

  WelcomeManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              const FirstPage(),
              const SecondPage(),
              const ThirdPage(),
              FourthPage(onSkip: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                  (route) => false,
                );
              }),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: const ExpandingDotsEffect(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 120),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Image.asset(
              "images/welcome/w-icon-1.png",
              scale: 1.7,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              "Learn programming from your phone easily through many tools that save you from using a computer",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 120),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Image.asset(
              "images/welcome/w-icon-2.png",
              scale: 1.7,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              "Quizzes for each lesson, including multiple choice questions and questions by writing the code.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 120),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Image.asset(
              "images/welcome/w-icon-3.png",
              scale: 1.7,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              "Statistics about your current level and progress so that you can know your development in a continuous and organized manner.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  final VoidCallback onSkip;
  
  const FourthPage({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 120),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Image.asset(
              "images/welcome/w-icon-4.png",
              scale: 1.7,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              "A complete computer in your hand to learn programming languages. You can learn the entire courses using this program without the need for a computer",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: onSkip,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueAccent,
              ),
              child: SizedBox(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Skip ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Image.asset(
                      "images/welcome/refer.png",
                      scale: 20,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
