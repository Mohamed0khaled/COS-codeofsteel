import 'package:flutter/material.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disclaimer"),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: const Text(
              '''
The information provided in Code of Steel is for educational purposes only. We are not liable for any damages or losses caused by the use of this app.
              ''',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}