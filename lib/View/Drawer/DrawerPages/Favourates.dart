import 'package:coursesapp/Controller/course_class.dart';
import 'package:coursesapp/Courses/cpp/cpp_home.dart';
import 'package:coursesapp/View/Drawer/Drawer.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class FavouratesPage extends StatefulWidget {
  const FavouratesPage({super.key});

  @override
  _FavouratesPageState createState() => _FavouratesPageState();
}

class _FavouratesPageState extends State<FavouratesPage> {
  final CourseService _courseService = CourseService();
  List<Course> favoriteCourses = [];
  bool isLoading = true;
  late String userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userId = UserIdProvider.of(context);
    if (userId.isNotEmpty && favoriteCourses.isEmpty && isLoading) {
      fetchFavoriteCourses();
    }
  }

  Future<void> fetchFavoriteCourses() async {
    try {
      final courses = await _courseService.getFavoriteCourses(userId);
      if (mounted) {
        setState(() {
          favoriteCourses = courses;
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching favorite courses: $e");
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
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
          : favoriteCourses.isEmpty
              ? const Center(child: Text("No favorite courses found"))
              : Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6, // Adjusted for better fit
                    ),
                    itemCount: favoriteCourses.length,
                    itemBuilder: (context, index) {
                      final course = favoriteCourses[index];
                      String cname = course.name; // Default value
                      if (course.name == "cpp_course") {
                        cname = "C++ Course";
                      } else if (course.name == "mp_as_course") {
                        cname = "MP Course";
                      }

                      return GestureDetector(
                        onTap: () {
                          if (course.id == 0) {
                            Get.to(() => const CppPage());
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 230,
                                  margin: const EdgeInsets.only(
                                      bottom: 5.0, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(course.cardImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 120,
                                  child: IconButton(
                                    icon: Icon(
                                      course.favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.redAccent,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        course.favorite = !course.favorite;
                                      });
                                      await _courseService.updateFavorite(
                                          userId, course.id, course.favorite);
                                      fetchFavoriteCourses();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                cname,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
