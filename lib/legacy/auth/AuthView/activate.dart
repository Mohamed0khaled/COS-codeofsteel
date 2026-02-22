import 'package:coursesapp/legacy/auth/AuthController/authcon.dart';
import 'package:coursesapp/legacy/auth/AuthView/auth.dart';
import 'package:coursesapp/legacy/views/choose/choose.dart';
import 'package:coursesapp/legacy/views/snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ActivatePage extends StatelessWidget {
  ActivatePage({super.key});

  final AuthController _authController = AuthController();

  void refreshUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload(); // Reload the user's info from Firebase
      user = FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        print('Email is verified');
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          Get.offAll(() => const ChoosePage());
        } else {
          showCustomSnackbar(
              title: "Not Activated",
              message: "Check Your Email Inbox And Click On Activate Link.",
              color: Colors.red);
          print(
              "Not Verified ============================================================");
        }
        // Proceed with allowing user access to the app or certain features
      } else {
        print('Email is not verified');
        // Show a message asking the user to verify their email
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "images/auth/protection.png",
              scale: 3,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Activate Your Email",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "We Have Send a Massage to your email check the inbox and click on the link to activate the account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.pink),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: const Text(
                "ReSend",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              _authController.EmailVerification();
            },
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: const Text(
                "Back To Signup",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              if (FirebaseAuth.instance.currentUser == null) {
                Get.offAll(() => const AuthPage());
              } else {
                _authController.LogOut();
                Get.offAll(() => const AuthPage());
              }
            },
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: const Text(
                "I Activate It",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () async {
              refreshUser();
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                Get.offAll(() => const ChoosePage());
              } else {
                print(
                    "Not Verified ============================================================");
              }
            },
          ),
        ],
      ),
    );
  }
}
