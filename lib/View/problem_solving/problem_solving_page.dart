import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'package:coursesapp/View/shared/drawer/drawer_page.dart';

/// Level card images for problem solving
const List<String> levelImagePaths = [
  'images/levelcards/d.png',
  'images/levelcards/e.png',
  'images/levelcards/s.png',
  'images/levelcards/a_plus.png',
  'images/levelcards/a.png',
  'images/levelcards/b.png',
  'images/levelcards/c.png',
];

/// Problem solving page - migrated from legacy problemsolving.dart
/// Uses Navigator instead of GetX and ProfileCubit instead of UserData
class ProblemSolvingPage extends StatefulWidget {
  const ProblemSolvingPage({super.key});

  @override
  State<ProblemSolvingPage> createState() => _ProblemSolvingPageState();
}

class _ProblemSolvingPageState extends State<ProblemSolvingPage> {
  static const Color _themeColor = Color.fromARGB(255, 0, 97, 50);
  int _cardIndex = 0;
  String _programmingLanguage = "C++";

  @override
  void initState() {
    super.initState();
    _initializeProgrammingLanguage();
  }

  Future<void> _initializeProgrammingLanguage() async {
    // TODO: Get programming language from user preferences
    setState(() {
      _programmingLanguage = "C++";
    });
  }

  int _getLevelFromCardIndex(int index) {
    switch (index) {
      case 1:
        return 0; // E
      case 0:
        return 1; // D
      case 6:
        return 2; // C
      case 5:
        return 3; // B
      case 4:
        return 4; // A
      case 3:
        return 5; // A+
      case 2:
        return 6; // S
      default:
        return 0;
    }
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text("Profile Page")),
        ),
      ),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text("Settings Page")),
        ),
      ),
    );
  }

  void _navigateToSolvePage(BuildContext context) {
    final level = _getLevelFromCardIndex(_cardIndex);
    // TODO: Navigate to solve page with level parameter
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Solve Problems")),
          body: Center(
            child: Text(
              "Level: $level\nLanguage: cpp",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Problem Solving"),
        backgroundColor: _themeColor,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawerPage(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 390,
            decoration: BoxDecoration(
              color: _themeColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: const Text(
                    "Choose the level that you want to solve problems on",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Level swiper
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Swiper(
                        itemCount: 7,
                        layout: SwiperLayout.STACK,
                        itemWidth: double.maxFinite,
                        itemHeight: constraints.maxHeight * 0.80,
                        loop: true,
                        duration: 1200,
                        scrollDirection: Axis.vertical,
                        onIndexChanged: (index) {
                          setState(() {
                            _cardIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.1,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(levelImagePaths[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: double.maxFinite,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Featured",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _buildFeatureTile(
            icon: Icons.person,
            label: "View Profile",
            onTap: () => _navigateToProfile(context),
          ),
          _buildFeatureTile(
            icon: Icons.integration_instructions,
            label: "Programming Lang",
            onTap: () => _navigateToSettings(context),
            trailing: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    offset: const Offset(1, 1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-1, -1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                _programmingLanguage,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _navigateToSolvePage(context),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _themeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.black),
            Text(" $label", style: const TextStyle(color: Colors.black)),
            const Spacer(),
            if (trailing != null) trailing,
            const Icon(Icons.arrow_circle_right_rounded, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
