// ignore_for_file: unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coursesapp/Auth/AuthController/authcon.dart';
import 'package:coursesapp/Controller/course_class.dart';
import 'package:coursesapp/View/coming%20soon/comingsoon.dart';
import 'package:coursesapp/View/homepage.dart';
import 'package:coursesapp/core/providers/user_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:readmore/readmore.dart';

class MPAssimplyPage extends StatefulWidget {
  const MPAssimplyPage({super.key});

  @override
  State<MPAssimplyPage> createState() => _MPAssimplyPageState();
}

// This Course Id : 0001   <-  <-  <---------- important line ;;;;;;

class _MPAssimplyPageState extends State<MPAssimplyPage> {
  // Auth Control
  final AuthController _authController = AuthController();

  // Firebase Control
  CourseService courseService = CourseService();
  late String userId;
  bool _userIdInitialized = false;

  Course? course;
  bool _isBookMarked = false;
  bool _isfinished = false;
  bool _isfavourate = false;
  bool _isCourseOwned = false;
  bool _isLoading = false;
  int course_price = 500;

  TextEditingController discount = TextEditingController();

  // Color Text in Dark and Light
  Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.black;
  }

  @override
  void initState() {
    super.initState();
    // Note: _loadCourseDetails and _checkCourseOwnership called in didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_userIdInitialized) {
      userId = UserIdProvider.of(context);
      if (userId.isNotEmpty) {
        _userIdInitialized = true;
        _loadCourseDetails();
        _checkCourseOwnership();
      }
    }
  }

  Future<void> _addcourse() async {
    const int courseId = 0001;
    bool exists = await courseService.courseExists(userId, courseId);
    if (exists) {
      print("The course added before");
    } else {
      await courseService.addCourse(
          userId,
          Course(
              id: 0001,
              name: "mp_as_course",
              favorite: false,
              saved: false,
              finished: false,
              progress: 2,
              cardImage:
                  'https://drive.google.com/uc?id=1HtMKFAWdKdAudHfrKdeol1s92gI4AG7s&export=download',
              owned: false,
              price: course_price));
    }
  }

  // Function to load course details asynchronously
  Future<void> _loadCourseDetails() async {
    int courseId = 0001;
    Course? fetchedCourse =
        await courseService.getCourseDetails(userId, courseId);

    if (fetchedCourse != null) {
      setState(() {
        course = fetchedCourse;
        _isBookMarked = fetchedCourse.saved;
        _isfinished = fetchedCourse.finished;
        _isfavourate = fetchedCourse.favorite;
      });
    }
  }

  // Function to check if the user owns the course
  Future<void> _checkCourseOwnership() async {
    setState(() {
      _isLoading = true;
      print(_isLoading);
    });
    await Future.delayed(const Duration(seconds: 1));
    int courseId = 0001;
    bool courseExists = await courseService.isCourseOwned(userId, courseId);

    if (courseExists) {
      Course? fetchedCourse =
          await courseService.getCourseDetails(userId, courseId);

      setState(() {
        course = fetchedCourse;
        _isCourseOwned = true;
      });
    } else {
      _addcourse();
    }
    setState(() {
      _isLoading = false;
      print(_isLoading);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: _isLoading
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
          : Column(
              children: [
                // Upper section with background image, buttons, and gradient
                Stack(
                  children: [
                    // Background image
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Optional for rounded corners
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Matches the borderRadius in decoration
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://drive.google.com/uc?id=1ihYQVGoX6UnY58nK37OHQj1CrxZ4gECY&export=download',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade900,
                          ],
                          stops: const [
                            0.15,
                            0.8,
                          ],
                        ),
                      ),
                    ),
                    // Content over the background image
                    Positioned(
                      bottom: 10,
                      left: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Movie Poster
                          Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://drive.google.com/uc?id=1HtMKFAWdKdAudHfrKdeol1s92gI4AG7s&export=download',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Movie Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Intro To Microprocessor's and Assimply (2025)",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "2025 • 24h • 15eb • FHD+",
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 15),
                                ),
                                const SizedBox(height: 10),
                                const Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 20),
                                    SizedBox(width: 5),
                                    Text(
                                      "9.6 / 10",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action buttons
                    Positioned(
                      top: 30,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white),
                        onPressed: () {
                          // Back action
                          Get.offAll(() => const HomePage());
                        },
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 20,
                      child: Row(
                        children: [
                          // discount Button
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Discount"),
                                      content: TextField(
                                        decoration: InputDecoration(
                                          labelText: "copon",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        controller: discount,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (discount.text
                                                .trim()
                                                .isNotEmpty) {
                                              courseService.checkCode(
                                                  userId,
                                                  discount.text,
                                                  0001,
                                                  course_price);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.discount_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                            icon: Icon(
                                _isfavourate
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: Colors.white),
                            onPressed: () async {
                              // Toggle bookmarking
                              bool newFavorateStatus = !_isfavourate;

                              // Perform the asynchronous operation outside of setState
                              await courseService.updateFavorite(
                                  userId, 0001, newFavorateStatus);

                              // Update the state after the async operation is complete
                              setState(() {
                                _isfavourate = newFavorateStatus;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Lower section with Play Button and Actions
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // Play Button
                            // Play Button
                            // Play Button
                            // Play Button
                            // Play Button
                            // Play Button mohamed khaled salah arafa
                            ElevatedButton.icon(
                              onPressed: () async {
                                bool finished = false;
                                if (finished == true){
                                  if (_isCourseOwned == false) {
                                  await courseService.updateOwned(
                                      userId, 0001, true);
                                } else if (_isCourseOwned == true) {
                                  // Get.to(() => const CppCoursePage()); // here the inside page ===================================================================================
                                } else {}
                                }else{
                                  Get.to(() => ComingSoonPage(launch_date: 'September 15,2025', creator: 'Eng: Mohamed Khaled',));
                                }
                              },
                              label: Text(
                                _isCourseOwned ? "Open Course" : "Buy Now",
                                style: TextStyle(
                                    fontSize: 17, color: getTextColor(context)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Bottom actions (like, share)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _isBookMarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    // Toggle bookmarking
                                    bool newBookmarkStatus = !_isBookMarked;

                                    // Perform the asynchronous operation outside of setState
                                    await courseService.updateSaved(
                                        userId, 0001, newBookmarkStatus);

                                    // Update the state after the async operation is complete
                                    setState(() {
                                      _isBookMarked = newBookmarkStatus;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isfinished
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Add to finish
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Share action
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Description
                        Expanded(
                          child: ListView(
                            children: const [
                              ReadMoreText(
                                '- Introduction To C++ \n- Functions in C++  \n- OOP (Object Oriented Programming) \n- Data Structures \n- References in C++ \n- STL (Standard Template Library)\n- 30 Quizzes along the course \n- 10 Exams \n\nENG: Mohamed Khaled \nCost: 1000 EGY \n\nBy the end of the course, you’ll have the skills to confidently write and debug your own C++ programs, solve complex problems, and be well-prepared for advanced studies in computer science.\n',
                                trimMode: TrimMode.Line,
                                trimLines: 15,
                                colorClickableText: Colors.pink,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
