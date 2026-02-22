import 'package:coursesapp/Controller/course_class.dart';
import 'package:coursesapp/Courses/cpp/cpp_home.dart';
import 'package:coursesapp/View/Drawer/Drawer.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final CourseService _courseService = CourseService();
  List<Course> savedCourses = [];
  bool isLoading = true;
  late String userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userId = UserIdProvider.of(context);
    if (userId.isNotEmpty && savedCourses.isEmpty && isLoading) {
      fetchSavedCourses();
    }
  }

  Future<void> fetchSavedCourses() async {
    try {
      final courses = await _courseService.getSavedCourses(userId);
      setState(() {
        savedCourses = courses;
        isLoading = false;
      });
      Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching saved courses: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved")),
      drawer: const DrawerPage(),
      body: isLoading
          ? const Center(
              child: SizedBox(
                width: 90,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [Colors.blue, Colors.red, Colors.green],
                  strokeWidth: 2,
                ),
              ),
            )
          : savedCourses.isEmpty
              ? const Center(child: Text("No saved courses found"))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2, // Set number of items per row (2 in this case)
                    crossAxisSpacing: 10, // Horizontal spacing between items
                    mainAxisSpacing: 10, // Vertical spacing between items
                    childAspectRatio:
                        0.65, // Adjust aspect ratio for better fit
                  ),
                  itemCount: savedCourses.length,
                  itemBuilder: (context, index) {
                    final course = savedCourses[index];
                    return GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double
                                    .infinity, // Ensure it takes full width
                                height:
                                    220, // Set a fixed height for the image container
                                margin: const EdgeInsets.only(
                                    bottom: 5.0, left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(course.cardImage),
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the container
                                  ),
                                ),
                              ),
                              // Heart icon button on top right
                              Positioned(
                                top: 5,
                                right: 120,
                                child: IconButton(
                                  icon: Icon(
                                    // Use a filled or outline heart based on saved status
                                    course.saved
                                        ? Icons.bookmark
                                        : Icons.bookmark_border_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    // Implement saved toggle functionality here
                                    setState(() {
                                      // Toggle the saved status here
                                      course.saved = !course.saved;
                                    });
                                    await _courseService.updateSaved(
                                        userId, course.id, course.saved);
                                    fetchSavedCourses(); // Refresh The List
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              course.name,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navigate to course details or handle onTap functionality
                        if (course.id == 0) {
                          // id = 0 in c++ course
                          Get.to(() => const CppPage());
                        }
                      },
                    );
                  },
                ),
    );
  }
}
