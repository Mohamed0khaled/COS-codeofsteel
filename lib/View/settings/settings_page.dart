import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coursesapp/features/theme/theme.dart';
import 'package:coursesapp/features/localization/localization.dart';
import 'package:coursesapp/View/shared/drawer/drawer_page.dart';

/// Settings page - migrated from legacy setting.dart
/// Uses Navigator instead of GetX for navigation
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                    // TODO: Update user's programming language preference
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _navigateToPolicy(BuildContext context, String policyName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(policyName)),
          body: Center(child: Text("$policyName content")),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const AppDrawerPage(),
      body: ListView(
        children: [
          _buildSectionHeader("General"),
          ListTile(
            leading: const Icon(Icons.sunny),
            trailing: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDarkMode =
                    state is ThemeLoaded ? state.isDarkMode : false;
                return Switch(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
            title: const Text("Dark Mode"),
          ),
          BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              final isArabic = state is LocaleLoaded ? state.isArabic : false;
              return ListTile(
                leading: const Icon(Icons.translate_rounded),
                trailing: Switch(
                  value: isArabic,
                  onChanged: (bool value) {
                    context.read<LocaleCubit>().toggleLocale();
                  },
                ),
                title: const Text("Arabic Mode"),
              );
            },
          ),
          _buildSectionHeader("Problem Solving"),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text("Programming Language"),
            onTap: _showLanguageBottomSheet,
          ),
          _buildSectionHeader("Policies"),
          _buildPolicyTile(
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            onTap: () => _navigateToPolicy(context, "Privacy Policy"),
          ),
          _buildPolicyTile(
            icon: Icons.article,
            title: "Terms of Use",
            onTap: () => _navigateToPolicy(context, "Terms of Use"),
          ),
          _buildPolicyTile(
            icon: Icons.report,
            title: "Disclaimer",
            onTap: () => _navigateToPolicy(context, "Disclaimer"),
          ),
          _buildPolicyTile(
            icon: Icons.handshake,
            title: "User Agreement",
            onTap: () => _navigateToPolicy(context, "User Agreement"),
          ),
          _buildPolicyTile(
            icon: Icons.money_off,
            title: "Refund Policy",
            onTap: () => _navigateToPolicy(context, "Refund Policy"),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPolicyTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
