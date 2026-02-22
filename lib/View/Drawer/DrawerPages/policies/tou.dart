import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms of Use"),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: const Text(
              '''
Welcome to Code of Steel! By using our app, you agree to the following terms and conditions.

1. User Conduct

You agree not to:
- Use the app for illegal activities.
- Share harmful or inappropriate content.

2. Intellectual Property

All content within the app, including text, designs, and code, is owned by Code of Steel. You may not copy, distribute, or modify any content without our permission.

3. Liability

We are not responsible for:
- Errors or interruptions in service.
- Loss of data caused by third-party services.

4. Modifications

We reserve the right to modify these terms at any time. Users will be notified of significant changes.

5. Termination

We reserve the right to terminate or suspend your access if you violate these terms.
              ''',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}