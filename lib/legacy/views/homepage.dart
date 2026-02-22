import 'package:coursesapp/legacy/views/courses/c.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coursesapp/legacy/auth/AuthController/userdatacontroller.dart';
import 'package:coursesapp/legacy/views/Drawer/Drawer.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/problemsolving/card_course.dart';
import 'package:coursesapp/legacy/views/courses/Popular/popular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:async'; // Import for Timer

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserData _userData = UserData();
  // TODO: Remove FirebaseAuth import and get user from AuthCubit when fully migrated
  final user = FirebaseAuth.instance.currentUser;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<CourseCard> allCourses = [];
  List<CourseCard> filteredCourses = [];
  String popandres = "Popular Courses";
  Timer? _debounce; // Timer for debounce mechanism

  // Color Text in Dark and Light
  Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.4)
        : Colors.black.withOpacity(0.6);
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Update any data or state that should refresh on the page
      _userData.updateRankAndLevel();
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize allCourses with all courses initially
    allCourses = popCourses + IntroductionCourses + AdvancedCourses;
    filteredCourses = allCourses;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    _debounce?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Helper method to filter courses based on search query
  List<CourseCard> _filterCourses(String query) {
    if (query.isEmpty) {
      return allCourses;
    }
    return allCourses
        .where((course) =>
            course.label.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Debounce mechanism for search
  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel(); // Cancel previous timer
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        filteredCourses = _filterCourses(value);
      });
    });
  }

  // Helper method to build course cards
  List<Widget> _buildCourseCards(List<CourseCard> courses) {
    return courses.map((course) => course).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        actions: [
          FutureBuilder<String>(
            future: _userData.getRank(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a placeholder while the rank is being fetched
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                );
              } else if (snapshot.hasError) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "Error",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                // Display the rank
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    snapshot.data ?? "N/A",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 19,
              backgroundColor: Colors.yellow[700],
              child: CircleAvatar(
                radius: 60,
                backgroundImage: user?.photoURL != null
                    ? CachedNetworkImageProvider(user!.photoURL!)
                    : null,
                child: user?.photoURL == null
                    ? const Icon(Icons.person, size: 50, color: Colors.red)
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        animSpeedFactor: 5,
        showChildOpacityTransition: false,
        color: Colors.blue,
        onRefresh: _handleRefresh,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 30),
              child: Text(
                "C o d e   o f   s t e e l",
                style: TextStyle(color: getTextColor(context), fontSize: 17),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 30),
              child: const Text(
                "Learn Any Time \n           Any Where!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged, // Use debounced search
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    popandres = "Popular Courses";
                  });
                },
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    popandres = "Popular Courses";
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search for courses',
                  fillColor: Colors.grey,
                  prefixIconColor: Colors.blue,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            // Display Search Results or Default Courses
            if (_searchController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 230,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _buildCourseCards(filteredCourses),
                  ),
                ),
              )
            else
              Column(
                children: [
                  // Popular Courses Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          "Popular Courses",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            "see all",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        onTap: () {
                          Get.to(() => PopularPage());
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 230,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildCourseCards(popCourses),
                      ),
                    ),
                  ),

                  // Introduction Courses Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          "Introduction Courses",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            "see all",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 230,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildCourseCards(IntroductionCourses),
                      ),
                    ),
                  ),

                  // Advanced Courses Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          "Advanced Courses",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            "see all",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 230,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildCourseCards(AdvancedCourses),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}