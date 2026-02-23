import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coursesapp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:coursesapp/features/auth/presentation/cubit/auth_state.dart';
import 'package:coursesapp/core/widgets/custom_snackbar.dart';
import 'signin_page.dart';
import 'activate_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showCustomSnackbar(
            context: context,
            title: "Error",
            message: state.message,
            color: Colors.red,
          );
        } else if (state is AuthAuthenticated && !state.user.emailVerified) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ActivatePage()),
          );
        } else if (state is AuthAuthenticated) {
          // Navigation handled by main.dart BlocBuilder
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: Scaffold(
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
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: TextFormField(
                  controller: _usernameController,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(labelText: "User Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: TextFormField(
                  controller: _emailController,
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
                  controller: _passwordController,
                  obscureText: false,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(30)),
                      alignment: Alignment.center,
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<AuthCubit>().register(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                  username: _usernameController.text.trim(),
                                );
                          },
                  );
                },
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return GestureDetector(
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<AuthCubit>().signInWithGoogle();
                          },
                  );
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SigninPage()),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
