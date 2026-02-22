import 'package:coursesapp/legacy/auth/AuthController/authcon.dart';
import 'package:coursesapp/legacy/auth/AuthView/Signin.dart';
import 'package:coursesapp/legacy/auth/AuthView/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthController _authController = AuthController();
  @override
  void initState() {
    _authController.dispose();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                color: Colors.black,
                child: Image.asset(
                  "images/auth/Artboard 1.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                height: 340,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 25),
                        padding: const EdgeInsets.only(top: 35),
                        child: Text(
                          "Welcome To",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 35,
                              fontWeight: FontWeight.w900),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: const Text(
                          "COS",
                          style: TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 45,
                              fontWeight: FontWeight.w900),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: const Text(
                          "C o d e  O f  S t e e l",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: const Text(
                          "For Programming and Engneering Courses",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1.5, color: Colors.blue.shade900)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    // go to sign up page
                    Get.to(() => SignupPage());
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(right: 42),
                    child: const Text(
                      "Sign in",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    // go to sign in page
                    Get.to(() =>  SigninPage());
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}