import 'package:coursesapp/Auth/AuthView/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class fourthPage extends StatelessWidget {
  const fourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 120,
        ),
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
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent),
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
                          fontSize: 20),
                    ),
                    Image.asset(
                      "images/welcome/refer.png",
                      scale: 20,
                      color: Colors.white,
                    )
                  ],
                ),
              )),
          onTap: () {
            // function when click on skip (Go to Login)
            print("Skip");
            Get.offAll(() => const AuthPage());
          },
        )
      ],
    ));
  }
}
