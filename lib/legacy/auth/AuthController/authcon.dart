// ignore_for_file: unused_local_variable
import 'package:coursesapp/legacy/auth/AuthController/userdatacontroller.dart';
import 'package:coursesapp/legacy/auth/AuthView/activate.dart';
import 'package:coursesapp/legacy/auth/AuthView/auth.dart';
import 'package:coursesapp/legacy/views/choose/choose.dart';
import 'package:coursesapp/legacy/views/homepage.dart';
import 'package:coursesapp/legacy/views/snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Legacy AuthController - manages form state and auth operations.
/// 
/// TODO: MIGRATION PLAN
/// 1. Move TextEditingControllers to individual screen widgets
/// 2. Replace signUp/signIn/signInWithGoogle with AuthCubit methods
/// 3. Replace LogOut with AuthCubit.logout()
/// 4. Replace navigation (Get.to/Get.offAll) with BlocListener on AuthCubit
/// 5. Move error handling to AuthCubit states (AuthError)
/// 6. Delete this file once all screens are migrated
class AuthController {
  final UserData _userData = UserData();
  // Controllers for email and password input fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  // Erorrs variable
  String erorr = "Try Again";

  // Function to sign up a user
  Future<void> signUp() async {
    try {
      // Create a new user with email and password
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // After signing up, store the username in Firestore
      String? uid = credential.user?.uid; // Ensure the user is not null
      if (uid != null) {
        await _userData.addUser(usernameController
            .text); // Replace "desiredUsername" with the actual username input
        print('Username added to Firestore.');
      }

      _fetchUsername();

      // Send email verification
      EmailVerification();
      Get.to(() => ActivatePage());

      print('User signed up: ${credential.user?.email}');
      print('Now going to activate...');
    } on FirebaseAuthException catch (e) {
      // Handle different error scenarios
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        erorr = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        erorr = "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
        erorr = "The email address is not valid.";
      } else {
        print('An unknown error occurred: ${e.message}');
        erorr = "An unknown error occurred: ${e.message}";
      }
      Get.to(() => const ChoosePage());
    } catch (e) {
      // Handle any other errors
      print('Error: $e');
      erorr = "Error: $e";
    }
  }

  // Function to verify email
  Future<void> EmailVerification() async {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  // Function to sign in with email and password
  Future<void> signIn() async {
    print(emailController.text);
    print(passwordController.text);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // _fetchUsername();
      Get.offAll(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      erorr = "The Email or Password is incorrect.";
      print(e.code);
      erorr = e.code;
    }
  }

  Future<String?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print(
        "frist================================================================================================");
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    print(
        "second================================================================================================");

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print(
        "third================================================================================================");

    // Once signed in, get the UserCredential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(
        "fourth================================================================================================");
    // Access data
    final User? user = userCredential.user;
    final String? username = user?.displayName;
    //_fetchUsername();
    print(
        "fifth================================================================================================");
    if (username != null) {
      _userData.addUser(username);
    } else {
      print("Username is null. Cannot add user.");
    }

    print(
        "6================================================================================================");
    return null;
  }

  // Logout Function
  Future<void> LogOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const AuthPage());
  }

  // Function to dispose of the controllers when they are no longer needed
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    erorr = "";
  }

  void refreshUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload(); // Reload the user's info from Firebase
      user = FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        print('Email is verified');
        // Proceed with allowing user access to the app or certain features
      } else {
        print('Email is not verified');
        showCustomSnackbar(
            title: "Not Activated",
            message: "Check Your Email Inbox And Click On Activate Link.",
            color: Colors.red);
        // Show a message asking the user to verify their email
      }
    }
  }

  Future<void> _fetchUsername() async {
    String username = await _userData.getUsername();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
  }
}
