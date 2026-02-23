import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:async';

import 'package:coursesapp/features/user_profile/user_profile.dart';
import 'package:coursesapp/features/courses/courses.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';
import 'package:coursesapp/View/shared/drawer/drawer_page.dart';
import 'package:coursesapp/View/shared/widgets/course_card.dart';
import 'package:coursesapp/View/courses/course_detail_page.dart';

/// Home page - migrated from legacy homepage.dart
/// Uses ProfileCubit instead of UserData for state management
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<CourseCardData> allCourses = [];
  List<CourseCardData> filteredCourses = [];
  String popandres = "Popular Courses";
  Timer? _debounce;
  late String _userId;
  bool _userIdInitialized = false;

  Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.4)
        : Colors.black.withOpacity(0.6);
  }

  Future<void> _handleRefresh() async {
    if (mounted && _userId.isNotEmpty) {
      // Reload profile and courses data
      context.read<ProfileCubit>().loadProfile(_userId);
      context.read<CoursesCubit>().loadAllCourses(_userId);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCourses();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_userIdInitialized) {
      _userId = UserIdProvider.of(context);
      _userIdInitialized = true;
      
      // Load profile and courses data when home page is first displayed
      if (_userId.isNotEmpty) {
        context.read<ProfileCubit>().loadProfile(_userId);
        context.read<CoursesCubit>().loadAllCourses(_userId);
      }
    }
  }

  void _initializeCourses() {
    // Courses are now loaded from Firestore via CoursesCubit
    // This method is kept for compatibility but courses come from BlocBuilder
    allCourses = [];
    filteredCourses = allCourses;
  }

  /// Convert CourseEntity to CourseCardData for display
  CourseCardData _entityToCardData(CourseEntity entity) {
    return CourseCardData(
      imageAddress: entity.cardImage,
      label: entity.name,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(course: entity),
          ),
        );
      },
    );
  }

  /// Convert list of CourseEntity to list of CourseCardData
  List<CourseCardData> _entitiesToCardData(List<CourseEntity> entities) {
    return entities.map(_entityToCardData).toList();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  List<CourseCardData> _filterCourses(String query) {
    if (query.isEmpty) {
      return allCourses;
    }
    return allCourses
        .where((course) =>
            course.label.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        filteredCourses = _filterCourses(value);
      });
    });
  }

  List<Widget> _buildCourseCards(List<CourseCardData> courses) {
    return courses.map((course) => course.toWidget()).toList();
  }

  void _navigateToPopularPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text("Popular Page")),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawerPage(),
      appBar: AppBar(
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              String rank = "N/A";
              String? photoUrl;

              if (state is ProfileLoaded) {
                rank = state.profile.rank;
                photoUrl = state.profile.imageUrl;
              } else if (state is ProfileUpdating) {
                rank = state.currentProfile.rank;
                photoUrl = state.currentProfile.imageUrl;
              } else if (state is ProfileUpdateSuccess) {
                rank = state.profile.rank;
                photoUrl = state.profile.imageUrl;
              } else if (state is ProfileLoading || state is ProfileInitial) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                );
              }

              return Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      rank,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.yellow[700],
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: photoUrl != null
                            ? CachedNetworkImageProvider(photoUrl)
                            : null,
                        child: photoUrl == null
                            ? const Icon(Icons.person,
                                size: 50, color: Colors.red)
                            : null,
                      ),
                    ),
                  ),
                ],
              );
            },
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
                onChanged: _onSearchChanged,
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
                  prefixIcon: const Icon(Icons.search, size: 30),
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
              BlocBuilder<CoursesCubit, CoursesState>(
                builder: (context, state) {
                  if (state is CoursesLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  
                  if (state is CoursesError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('Error: ${state.message}'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => context.read<CoursesCubit>().loadAllCourses(_userId),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  
                  List<CourseEntity> courses = [];
                  if (state is CoursesListLoaded) {
                    courses = state.courses;
                    // Update local lists for search functionality
                    allCourses = _entitiesToCardData(courses);
                    filteredCourses = allCourses;
                  }
                  
                  if (courses.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50.0),
                        child: Text(
                          'No courses available.\nPull down to refresh.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  
                  return Column(
                    children: [
                      // All Courses Section
                      _buildCourseSectionHeader(
                        context,
                        title: "All Courses",
                        onSeeAll: () => _navigateToPopularPage(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 230,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _buildCourseCards(_entitiesToCardData(courses)),
                          ),
                        ),
                      ),

                      // Owned Courses Section
                      if (courses.where((c) => c.owned).isNotEmpty) ...[
                        _buildCourseSectionHeader(
                          context,
                          title: "My Courses",
                          onSeeAll: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 230,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _buildCourseCards(
                                _entitiesToCardData(courses.where((c) => c.owned).toList()),
                              ),
                            ),
                          ),
                        ),
                      ],

                      // In Progress Courses Section
                      if (courses.where((c) => c.progress > 0 && !c.finished).isNotEmpty) ...[
                        _buildCourseSectionHeader(
                          context,
                          title: "Continue Learning",
                          onSeeAll: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 230,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _buildCourseCards(
                                _entitiesToCardData(
                                  courses.where((c) => c.progress > 0 && !c.finished).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "see all",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
