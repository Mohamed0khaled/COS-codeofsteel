import 'package:coursesapp/legacy/welcome/fourth.dart';
import 'package:coursesapp/legacy/welcome/frist.dart';
import 'package:coursesapp/legacy/welcome/second.dart';
import 'package:coursesapp/legacy/welcome/third.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            children: const [
              FristPage(),
              SecondPage(),
              ThirdPage(),
              fourthPage()
            ],
          ),
          // Adding SmoothPageIndicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                  controller: _controller, // PageController
                  count: 4, // Number of pages
                  effect: const ExpandingDotsEffect()),
            ),
          ),
        ],
      ),
    );
  }
}
