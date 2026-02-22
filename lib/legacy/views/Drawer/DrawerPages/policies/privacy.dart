import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: const Text(
              '''
At Code of Steel, we are committed to protecting your personal information and your right to privacy. This Privacy Policy explains what information we collect, how we use it, and your rights in relation to it. By using our app, you agree to the terms outlined here.

1. Information We Collect

Personal Data: Such as your name, email address, and phone number.
Usage Data: Information about how you use the app, including features accessed and time spent on the platform.

2. How We Use Your Information

To improve our app’s functionality.
To communicate with you regarding updates or support.
To comply with legal requirements.

3. Sharing Your Information

We do not share your personal information with third parties unless:
- Required by law.
- Necessary for app functionality (e.g., third-party payment processors).

4. Your Rights

Access: You can request access to the data we hold about you.
Deletion: You can request the deletion of your data.

5. Contact Us

For any privacy concerns, contact us at
              ''',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: InkWell(
              child: const Text(
                "support@codeofsteel.com.",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Function to contact via mail
                // You can use the `url_launcher` package to open the email client.
                // Example:
                // final Uri emailLaunchUri = Uri(
                //   scheme: 'mailto',
                //   path: 'support@codeofsteel.com',
                // );
                // launch(emailLaunchUri.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}