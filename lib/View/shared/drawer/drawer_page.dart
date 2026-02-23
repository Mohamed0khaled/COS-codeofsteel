import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:coursesapp/features/user_profile/user_profile.dart';
import 'category_widget.dart';

/// Main application drawer with user profile and navigation
class AppDrawerPage extends StatefulWidget {
  const AppDrawerPage({super.key});

  @override
  State<AppDrawerPage> createState() => _AppDrawerPageState();
}

class _AppDrawerPageState extends State<AppDrawerPage> {
  String _username = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  /// Load username from SharedPreferences or fetch from ProfileCubit
  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    // Try to load cached username
    final cachedUsername = prefs.getString('username');
    if (cachedUsername != null && mounted) {
      setState(() {
        _username = cachedUsername;
      });
    }
  }

  void _navigateToContactPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactWithMePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                String displayName = _username;
                String? imageUrl;
                
                if (state is ProfileLoaded) {
                  displayName = state.profile.username;
                  imageUrl = state.profile.imageUrl;
                } else if (state is ProfileUpdating) {
                  displayName = state.currentProfile.username;
                  imageUrl = state.currentProfile.imageUrl;
                } else if (state is ProfileUpdateSuccess) {
                  displayName = state.profile.username;
                  imageUrl = state.profile.imageUrl;
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 19,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: imageUrl != null
                              ? NetworkImage(imageUrl)
                              : null,
                          child: imageUrl == null
                              ? const Icon(Icons.person,
                                  size: 50, color: Colors.grey)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // User's name
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Categories
          const Expanded(
            child: CategoriesWidget(),
          ),

          ListTile(
            selected: true,
            selectedTileColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            onTap: () => _navigateToContactPage(context),
            title: const Text(
              "C o n t a c t  W i t h  M e",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.contact_support,
              size: 33,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Contact With Me page (migrated from CWMPage)
class ContactWithMePage extends StatelessWidget {
  const ContactWithMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Contact With Me"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      drawer: const AppDrawerPage(),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.transparent,
              child: Image.asset("images/logo.png"),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: const Text(
              "Contact Via",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          const SizedBox(height: 25),
          _buildContactTile(
            icon: Icons.email,
            label: "Contact Via Email",
            onTap: () {
              // TODO: Implement email contact
            },
          ),
          _buildContactTile(
            icon: Icons.chat,
            label: "Contact Via WhatsApp",
            onTap: () {
              // TODO: Implement WhatsApp contact
            },
          ),
          _buildContactTile(
            icon: Icons.facebook,
            label: "Contact Via Facebook",
            onTap: () {
              // TODO: Implement Facebook contact
            },
          ),
          _buildContactTile(
            icon: Icons.code,
            label: "Contact Via GitHub",
            onTap: () {
              // TODO: Implement GitHub contact
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
