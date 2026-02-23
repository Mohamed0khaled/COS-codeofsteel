import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:coursesapp/features/courses/courses.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';
import 'package:coursesapp/View/shared/drawer/drawer_page.dart';

/// Saved courses page - uses BLoC pattern
class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late String userId;
  bool _userIdInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_userIdInitialized) {
      userId = UserIdProvider.of(context);
      _userIdInitialized = true;
      if (userId.isNotEmpty) {
        context.read<CoursesCubit>().loadSavedCourses(userId);
      }
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
      appBar: AppBar(title: const Text("Saved")),
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
            final savedCourses = state.courses;

            if (savedCourses.isEmpty) {
              return const Center(child: Text("No saved courses found"));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: savedCourses.length,
              itemBuilder: (context, index) {
                final course = savedCourses[index];
                return GestureDetector(
                  onTap: () => _navigateToCourse(context, course.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 220,
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
                                course.saved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              onPressed: () {
                                context.read<CoursesCubit>().toggleSaved(
                                      userId,
                                      course.id,
                                      course.saved,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          course.name,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
