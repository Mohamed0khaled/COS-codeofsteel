import 'package:coursesapp/Auth/AuthController/userdatacontroller.dart';
import 'package:coursesapp/Controller/language/languageController.dart';
import 'package:coursesapp/Controller/theme/theme.dart';
import 'package:coursesapp/View/Drawer/Drawer.dart';
import 'package:coursesapp/View/Drawer/DrawerPages/policies/disclaimer.dart';
import 'package:coursesapp/View/Drawer/DrawerPages/policies/privacy.dart';
import 'package:coursesapp/View/Drawer/DrawerPages/policies/refund.dart';
import 'package:coursesapp/View/Drawer/DrawerPages/policies/tou.dart';
import 'package:coursesapp/View/Drawer/DrawerPages/policies/uagree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ThemeController _themeController = Get.find();
  final LangController _langController = Get.find();
  UserData _userData = UserData();

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose Programming Language",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...['C++', 'Python', 'Dart', 'Java'].map((language) {
                return ListTile(
                  title: Text(language),
                  onTap: () {
                    setState(() {
                      _userData.updateUserpspl(language); // Update in Firebase
                    });
                    Navigator.pop(context); // Close the bottom sheet
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  // Variable to track the selected programming language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      drawer: const DrawerPage(),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: const Text(
              "General",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sunny),
            trailing: Switch(
              value: _themeController.isDarkMode.value,
              onChanged: (bool value) {
                setState(() {
                  _themeController.toggleTheme();
                });
              },
            ),
            title: const Text("Dark Mode"),
          ),
          Obx(() {
            return ListTile(
              leading: const Icon(Icons.translate_rounded),
              trailing: Switch(
                value: _langController.isArabic.value,
                onChanged: (bool value) {
                  setState(() {
                    _langController.ChangeLang(value ? 'ar' : 'en');
                  });
                },
              ),
              title: const Text("Arabic Mode"),
            );
          }),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: const Text(
              "Problem Solving",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text("Programming Language"),
            onTap: _showLanguageBottomSheet,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: const Text(
              "Policies",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => PrivacyPage());
            },
            child: ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: Text("Privacy Policy"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => TermsOfUsePage());
            },
            child: ListTile(
              leading: const Icon(Icons.article),
              title: Text("Terms of Use"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => DisclaimerPage());
            },
            child: ListTile(
              leading: const Icon(Icons.report),
              title: Text("Disclaimer"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => UserAgreementPage());
            },
            child: ListTile(
              leading: const Icon(Icons.rule_rounded),
              title: Text("User Agreement"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => RefundPolicyPage());
            },
            child: ListTile(
              leading: const Icon(Icons.policy),
              title: Text("Refund Policy"),
            ),
          ),
        ],
      ),
    );
  }
}
