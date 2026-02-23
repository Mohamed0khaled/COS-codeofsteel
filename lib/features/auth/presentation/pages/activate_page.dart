import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coursesapp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:coursesapp/features/auth/presentation/cubit/auth_state.dart';
import 'package:coursesapp/core/widgets/custom_snackbar.dart';
import 'auth_page.dart';

class ActivatePage extends StatelessWidget {
  const ActivatePage({super.key});

  Future<void> _refreshUser(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        // Refresh auth state
        context.read<AuthCubit>().checkAuthStatus();
      } else {
        showCustomSnackbar(
          context: context,
          title: "Not Activated",
          message: "Check Your Email Inbox And Click On Activate Link.",
          color: Colors.red,
        );
      }
    }
  }

  Future<void> _resendVerification(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      showCustomSnackbar(
        context: context,
        title: "Email Sent",
        message: "Verification email has been sent.",
        color: Colors.green,
      );
    } catch (e) {
      showCustomSnackbar(
        context: context,
        title: "Error",
        message: e.toString(),
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated && state.user.emailVerified) {
          // Navigation handled by main.dart
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: Scaffold(
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
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
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
              onTap: () => _resendVerification(context),
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
                context.read<AuthCubit>().logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                  (route) => false,
                );
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
              onTap: () => _refreshUser(context),
            ),
          ],
        ),
      ),
    );
  }
}
