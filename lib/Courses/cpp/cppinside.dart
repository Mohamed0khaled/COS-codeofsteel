import 'package:coursesapp/Controller/course_class.dart';
import 'package:coursesapp/Controller/quizeController/codeQuize.dart';
import 'package:coursesapp/Courses/cpp/Quizes/Quizes.dart';
import 'package:coursesapp/Courses/cpp/Quizes/Quize_template.dart';
import 'package:coursesapp/Courses/cpp/cpp_home.dart';
import 'package:coursesapp/Courses/cpp/pdfs/pdf_Template.dart';
import 'package:coursesapp/Courses/video_page.dart';
import 'package:coursesapp/View/courses/intile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CppCoursePage extends StatefulWidget {
  const CppCoursePage({super.key});

  @override
  State<CppCoursePage> createState() => _CppCoursePageState();
}

class _CppCoursePageState extends State<CppCoursePage> {
  // Firebase and Course details
  final CourseService courseService = CourseService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  Course? course;
  int progress = 2;
  // Quizes Class
  final Quize _quize = Quize();

  // Refresh
  bool _isLoading = false;

  // This list tracks whether each tile is unlocked
  List<bool> _unlockedTiles = [];

  Color getElementBGColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.grey;
  }

  Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  Color GetTrueBGColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade700
        : Colors.white;
  }

  Color GetLockBGColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.white;
  }

  Color GetArrowBGColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.green.shade300
        : Colors.green;
  }

  @override
  void initState() {
    super.initState();
    _initializeUnlockedTiles(); // Initialize _unlockedTiles based on the initial progress value
    _loadCourseDetails(); // Load course details on initialization
  }

  void _initializeUnlockedTiles() {
    _unlockedTiles = List<bool>.generate(30, (index) => index < progress);
  }

  Future<void> _loadCourseDetails() async {
    // Refresh
    if (!mounted) return; // Check if the widget is still mounted
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    int courseId = 0000;
    Course? fetchedCourse =
        await courseService.getCourseDetails(userId, courseId);

    if (fetchedCourse != null) {
      course = fetchedCourse;
      progress = fetchedCourse.progress;
      _initializeUnlockedTiles();
    }

    // Refresh
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C++ Course Timeline'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print("Back button pressed");
            Get.offAll(() => const CppPage());
          },
        ),
      ),
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
          : ListView(
              padding: const EdgeInsets.all(15),
              children: [
                // Replace one of your TimelineTile entries with this implementation
                TimelineTile(
                  isFirst: true,
                  endChild: InTile(
                    title: 'Lesson 1',
                    onclick: _unlockedTiles[0]
                        ? () {
                            Get.to(() => VideoPage(
                                  apparTitle: "Lesson 1",
                                  videoURL: "https://youtu.be/EBmcT0DbfeM",
                                  // Add custom timestamps for this lesson
                                  timeStamps: [
                                    {
                                      'minutes': 0,
                                      'seconds': 20,
                                      'label': 'Intro'
                                    },
                                    {
                                      'minutes': 3,
                                      'seconds': 11,
                                      'label': 'Why C++'
                                    },
                                    {
                                      'minutes': 4,
                                      'seconds': 7,
                                      'label': 'C vs C++'
                                    },
                                    {
                                      'minutes': 4,
                                      'seconds': 42,
                                      'label': 'C# vs C++'
                                    },
                                    {
                                      'minutes': 5,
                                      'seconds': 22,
                                      'label': 'Download VS Code'
                                    },
                                    {
                                      'minutes': 10,
                                      'seconds': 20,
                                      'label': 'Create new Project'
                                    },
                                    {
                                      'minutes': 11,
                                      'seconds': 10,
                                      'label': 'Start Coding'
                                    },
                                  ],
                                  nextpage: () {
                                    Get.to(
                                        () => PdfPage1(
                                              lesson_number: 1,
                                              pdf_link:
                                                  "https://drive.google.com/uc?id=1_NUTGcLvisZsayVsK6tuVdwQ3i-kTXVB&export=download",
                                              quize_page: QuizeTemplate(
                                                questions:
                                                    _quize.questions_cppfull_1,
                                              ),
                                            ),
                                        transition: Transition.rightToLeft);
                                  },
                                ));
                          }
                        : () {},
                    end_icon: Icon(
                      _unlockedTiles[0] ? Icons.arrow_circle_right : Icons.lock,
                      color: _unlockedTiles[0]
                          ? GetArrowBGColor(context)
                          : GetLockBGColor(context),
                    ),
                    color: _unlockedTiles[0]
                        ? GetTrueBGColor(context)
                        : getElementBGColor(context),
                  ),
                ),

// Example for another lesson with different timestamps
                TimelineTile(
                  endChild: InTile(
                    title: 'Lesson 2',
                    onclick: _unlockedTiles[1]
                        ? () {
                            Get.to(() => VideoPage(
                                apparTitle: "Lesson 2",
                                videoURL: "https://youtu.be/XarJjwXjgaw",
                                // Different timestamps for lesson 2
                                timeStamps: [
                                  {
                                    'minutes': 0,
                                    'seconds': 30,
                                    'label': 'Comments'
                                  },
                                  {
                                    'minutes': 2,
                                    'seconds': 45,
                                    'label': 'Variables'
                                  },
                                  {
                                    'minutes': 6,
                                    'seconds': 20,
                                    'label': 'Constants'
                                  },
                                  {
                                    'minutes': 9,
                                    'seconds': 15,
                                    'label': 'Practice'
                                  },
                                ],
                                nextpage: () {
                                  Get.to(
                                      () => PdfPage1(
                                            lesson_number: 2,
                                            pdf_link:
                                                'https://drive.google.com/uc?export=download&id=1EhJ9ldQ61lHD1BHe13QmH-qhbYH2wfNY',
                                            quize_page: QuizeTemplate(
                                                questions:
                                                    _quize.questions_cppfull_2),
                                          ),
                                      transition: Transition.rightToLeft);
                                }));
                          }
                        : () {},
                    end_icon: Icon(
                      _unlockedTiles[1] ? Icons.arrow_circle_right : Icons.lock,
                      color: _unlockedTiles[1]
                          ? GetArrowBGColor(context)
                          : GetLockBGColor(context),
                    ),
                    color: _unlockedTiles[1]
                        ? GetTrueBGColor(context)
                        : getElementBGColor(context),
                  ),
                ),
                TimelineTile(
                  endChild: InTile(
                    title: 'Lesson 3',
                    onclick: _unlockedTiles[2]
                        ? () {
                            // Function here
                            Get.to(() => VideoPage(
                                apparTitle: "Lesson 3",
                                videoURL: "https://youtu.be/Nd4gsWT9oPw",
                                nextpage: () {
                                  Get.to(
                                      () => PdfPage1(
                                            lesson_number: 2,
                                            pdf_link:
                                                'https://drive.google.com/uc?export=download&id=17fsQPSSl-GBKnjX4RSEwb6_m3YAF8AvQ',
                                            quize_page: QuizeTemplate(
                                                questions:
                                                    _quize.questions_cppfull_3),
                                          ),
                                      transition: Transition.rightToLeft);
                                }));
                            print("Opend");
                          }
                        : () {
                            print("Closed");
                          },
                    end_icon: Icon(
                      _unlockedTiles[2] ? Icons.arrow_circle_right : Icons.lock,
                      color: _unlockedTiles[2]
                          ? GetArrowBGColor(context)
                          : GetLockBGColor(context),
                    ),
                    color: _unlockedTiles[2]
                        ? GetTrueBGColor(context)
                        : getElementBGColor(context),
                  ),
                ),
                TimelineTile(
                  endChild: InTile(
                    title: 'Lesson 4',
                    onclick: _unlockedTiles[3]
                        ? () {
                            // Function here
                            Get.to(
                                () => PdfPage1(
                                      lesson_number: 2,
                                      pdf_link:
                                          'https://drive.google.com/uc?export=download&id=10Nwj2hpDPEKd4zPkQHBQA8hFuIQnedic',
                                      quize_page: QuizeTemplate(
                                          questions:
                                              _quize.questions_cppfull_4),
                                    ),
                                transition: Transition.rightToLeft);
                          }
                        : () {},
                    end_icon: Icon(
                      _unlockedTiles[3] ? Icons.arrow_circle_right : Icons.lock,
                      color: _unlockedTiles[3]
                          ? GetArrowBGColor(context)
                          : GetLockBGColor(context),
                    ),
                    color: _unlockedTiles[3]
                        ? GetTrueBGColor(context)
                        : getElementBGColor(context),
                  ),
                ),
                TimelineTile(
                  isLast: false,
                  endChild: InTile(
                    title: 'Lesson 5',
                    onclick: _unlockedTiles[4]
                        ? () {
                            // Function here
                          }
                        : () {},
                    end_icon: Icon(
                      _unlockedTiles[4] ? Icons.arrow_circle_right : Icons.lock,
                      color: _unlockedTiles[4]
                          ? GetArrowBGColor(context)
                          : GetLockBGColor(context),
                    ),
                    color: _unlockedTiles[4]
                        ? GetTrueBGColor(context)
                        : getElementBGColor(context),
                  ),
                ),
                TimelineTile(
                  isLast: false,
                  endChild: InTile(
                    title: 'Quize 1',
                    onclick: _unlockedTiles[5]
                        ? () {
                            // Function here
                            Get.to(() => CodeQuizePage(
                                  question:
                                      'Make C++ Code To Print Hello World',
                                ));
                          }
                        : () {},
                    end_icon: Icon(
                      _unlockedTiles[5] ? Icons.arrow_circle_right : Icons.lock,
                      color: _unlockedTiles[5]
                          ? GetArrowBGColor(context)
                          : GetLockBGColor(context),
                    ),
                    color: _unlockedTiles[5]
                        ? Colors.green
                        : getElementBGColor(context),
                  ),
                ),
                TimelineTile(
                  isLast: true,
                  endChild: InTile(
                    title: 'Lesson 6',
                    onclick: _unlockedTiles[6]
                        ? () {
                            // Function here
                          }
                        : () {},
                    end_icon: Icon(
                      _unlockedTiles[6] ? Icons.arrow_circle_right : Icons.lock,
                      color: _unlockedTiles[6]
                          ? GetArrowBGColor(context)
                          : GetLockBGColor(context),
                    ),
                    color: _unlockedTiles[6]
                        ? GetTrueBGColor(context)
                        : getElementBGColor(context),
                  ),
                ),
              ],
            ),
    );
  }
}


/*




to make link
https://drive.google.com/uc?export=download&id=

put your id after = 


// Function here
  Get.to(
      () => PdfPage1(
            lesson_number: 2,
            pdf_link:
                '',
            quize_page: QuizeTemplate(
                questions:
                    _quize.questions_cppfull_),
          ),
      transition: Transition.rightToLeft);
*/