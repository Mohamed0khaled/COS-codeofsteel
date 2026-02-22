import 'package:coursesapp/legacy/auth/AuthController/userdatacontroller.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/cwm.dart';
import 'package:coursesapp/legacy/views/Drawer/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  // TODO: Remove FirebaseAuth import and get user from AuthCubit when fully migrated
  final user = FirebaseAuth.instance.currentUser;
  final UserData _userData = UserData();

  String _username = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load username from SharedPreferences or fetch from Firebase
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Try to load the username from SharedPreferences
    String? cachedUsername = prefs.getString('username');

    if (cachedUsername != null) {
      // If cached username exists, use it
      setState(() {
        _username = cachedUsername;
      });
    }

    // Fetch the latest username from Firebase
    try {
      String username = await _userData.getUsername();
      if (mounted) {
        setState(() {
          _username = username;
        });
      }

      // Save the username to SharedPreferences for future use
      await prefs.setString('username', username);
    } catch (e) {
      // Handle errors (e.g., no internet connection)
      if (cachedUsername == null) {
        setState(() {
          _username = "Guest";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
            child: Column(
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
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.red)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // User's name
                Text(
                  _username,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          // Categories
          const Expanded(
            // Added to ensure CategoriesPage takes up the remaining space
            child: CategoriesPage(),
          ),

          Container(
            child: ListTile(
              selected: true,
              selectedTileColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              onTap: () {
                Get.off(() => const CWMPage());
              },
              title: const Text(
                "C o n t a c t  W i t h  M e",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              leading: const Icon(
                Icons.contact_support,
                size: 33,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}