import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:coursesapp/features/courses/courses.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';
import 'package:coursesapp/View/shared/drawer/drawer_page.dart';

/// Favourites page - uses BLoC pattern
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late String userId;
  bool _userIdInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_userIdInitialized) {
      userId = UserIdProvider.of(context);
      _userIdInitialized = true;
      if (userId.isNotEmpty) {
        context.read<CoursesCubit>().loadFavoriteCourses(userId);
      }
    }
  }

  String _getDisplayName(String courseName) {
    switch (courseName) {
      case "cpp_course":
        return "C++ Course";
      case "mp_as_course":
        return "MP Course";
      default:
        return courseName;
    }
  }

  void _navigateToCourse(BuildContext context, int courseId) {
    switch (courseId) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text("C++ Course Page")),
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      drawer: const AppDrawerPage(),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          if (state is CoursesLoading || state is CoursesInitial) {
            return const Center(
              child: SizedBox(
                width: 90,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [Colors.blue, Colors.red, Colors.green],
                  strokeWidth: 2,
                ),
              ),
            );
          }

          if (state is CoursesError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is CoursesListLoaded) {
            final favoriteCourses = state.courses;

            if (favoriteCourses.isEmpty) {
              return const Center(child: Text("No favorite courses found"));
            }

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6,
                ),
                itemCount: favoriteCourses.length,
                itemBuilder: (context, index) {
                  final course = favoriteCourses[index];
                  final displayName = _getDisplayName(course.name);

                  return GestureDetector(
                    onTap: () => _navigateToCourse(context, course.id),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 230,
                              margin: const EdgeInsets.only(
                                bottom: 5.0,
                                left: 10,
                              ),
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
                                onPressed: () {
                                  context.read<CoursesCubit>().toggleFavorite(
                                        userId,
                                        course.id,
                                        course.favorite,
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            displayName,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
