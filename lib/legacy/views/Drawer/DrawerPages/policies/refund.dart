import 'package:flutter/material.dart';

class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refund Policy"),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: const Text(
              '''
At Fawaterk, we strive to provide quality services. However, we understand that certain situations may require refunds. Below is our refund policy:

1. Eligibility for Refunds

Refunds are only available under the following conditions:
- The service was not delivered as promised.
- You were charged incorrectly due to a platform error.
- Cancellation of a subscription within the first 7 days (if no services were used).

2. Non-Refundable Cases

Refunds will not be issued for:
- Services that have already been used or delivered.
- Errors caused by the user, such as incorrect input or misuse of the platform.

3. Refund Process

To request a refund, contact us at
              ''',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: InkWell(
              child: const Text(
                "support@fawaterk.com",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Function to open email client
                // Example using url_launcher:
                // final Uri emailLaunchUri = Uri(
                //   scheme: 'mailto',
                //   path: 'support@fawaterk.com',
                // );
                // launch(emailLaunchUri.toString());
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text(
              '''
with proof of payment and details of your case.
Refunds may take up to 14 business days to process.

4. Changes to the Refund Policy

Fawaterk reserves the right to modify this policy at any time. Changes will be communicated via email or platform notifications.
              ''',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}