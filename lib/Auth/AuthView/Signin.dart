import 'package:coursesapp/Auth/AuthController/authcon.dart';
import 'package:coursesapp/Auth/AuthView/signup.dart';
import 'package:coursesapp/View/homepage.dart';
import 'package:coursesapp/View/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SigninPage extends StatelessWidget {

  // Firebase Class Call
  final AuthController _authController = AuthController();

  SigninPage({super.key});
  

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
                "Let's Sign You in.",
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
                "Sign in with your data that you have entered during your registration",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
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
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: TextFormField(
                controller: _authController.passwordController,
                obscureText: true,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  labelText: "Password",
                  
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, right: 5),
              child: InkWell(
                child: const Text(
                  "Forget Password?",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  // Go to Forget Password
                },
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
                  "Sign in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () {
                // signin button
                _authController.signIn();
                showCustomSnackbar(
                  title: "Erorr", 
                  message: _authController.erorr, 
                  color: Colors.red
                );
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
                      "sign in with Google",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // Google button action
                _authController.signInWithGoogle();
                Get.offAll(() => const HomePage());
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                InkWell(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.blue[900], fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // go to register page
                    _authController.dispose();
                    Get.to(() => SignupPage());
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
