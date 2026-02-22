import 'package:coursesapp/Auth/AuthController/authcon.dart';
import 'package:coursesapp/Auth/AuthView/Signin.dart';
import 'package:coursesapp/View/choose/choose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {

  // Firebase Class Call
  final AuthController _authController = AuthController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "images/auth/login.png",
                scale: 5,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                "Register.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: const Text(
                "Make new account to start learning and achive experience ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: TextFormField(
                controller: _authController.usernameController,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(labelText: "User Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: TextFormField(
                controller: _authController.emailController,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                    hintText: "example@gmail.com", labelText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
              child: TextFormField(
                controller: _authController.passwordController,
                obscureText: false,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () {
                // signup button  action
                _authController.signUp();
                
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade900),
                    borderRadius: BorderRadius.circular(30)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "images/auth/google.png",
                      scale: 16,
                    ),
                    const Text(
                      "signup with Google",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // login button action
                _authController.signInWithGoogle();
                Get.offAll(() => const ChoosePage());
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                InkWell(
                  child: Text(
                    "SignIn",
                    style: TextStyle(
                        color: Colors.blue[900], fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // go to register page
                    Get.to(() => SigninPage());
                    _authController.dispose();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
