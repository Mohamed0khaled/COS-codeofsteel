import 'package:flutter/material.dart';

class UserAgreementPage extends StatelessWidget {
  const UserAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Agreement"),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: const Text(
              '''
Welcome to Fawaterk! By using our platform, you agree to the terms outlined in this agreement. Please read it carefully before proceeding.

1. Account Creation

You must provide accurate and complete information during registration.
You are responsible for maintaining the security of your account credentials.
Sharing your account with unauthorized users is prohibited.

2. Platform Usage

Fawaterk is designed to help you create, manage, and process invoices.
You agree to use the platform for lawful purposes only.
You may not misuse the platform to engage in fraud, money laundering, or illegal activities.

3. Fees and Payments

Some services on Fawaterk may require payment of subscription fees.
Payments must be made on time to avoid interruptions to your service.
Non-payment may result in account suspension or termination.

4. Intellectual Property

All content on the platform, including the design, code, and branding, is owned by Fawaterk.
Unauthorized copying, redistribution, or modification of any content is strictly prohibited.

5. Limitation of Liability

Fawaterk is not responsible for any loss of data, revenue, or damages caused by misuse of the platform.
While we strive for platform stability, we cannot guarantee uninterrupted service.

6. Termination

We reserve the right to terminate your account if you violate these terms.

7. Amendments

We may update this agreement from time to time. Continued use of the platform constitutes acceptance of the updated terms.
              ''',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}