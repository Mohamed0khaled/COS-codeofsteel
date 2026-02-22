import 'package:coursesapp/legacy/courses/cpp/cpp_home.dart';
import 'package:coursesapp/legacy/courses/mp_ass.dart/mp_home.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/problemsolving/card_course.dart';
import 'package:get/get.dart';

List<CourseCard> popCourses = [
  CourseCard(
    imageAddress:
        "https://drive.google.com/uc?id=1cVrq9rlVMnCZEFBxfiBXJpmDQc1C3gzv&export=download",
    whenTap: () {
      // Go to C++ Course Page
      Get.to(() => const CppPage());
    },
    label: "C++ course",
  ),
  CourseCard(
    imageAddress:
        "https://drive.google.com/uc?id=1HtMKFAWdKdAudHfrKdeol1s92gI4AG7s&export=download",
    whenTap: () {
      Get.to(() => MPAssimplyPage());
    },
    label: "MP course",
  ),
  CourseCard(
    imageAddress:
        "https://media.springernature.com/full/springer-static/cover-hires/book/978-1-4302-0032-1",
    whenTap: () {},
    label: "JAVA course",
  ),
];

List<CourseCard> IntroductionCourses = [
  CourseCard(
    imageAddress:
        "https://drive.google.com/uc?id=1HtMKFAWdKdAudHfrKdeol1s92gI4AG7s&export=download",
    whenTap: () {
      Get.to(() => MPAssimplyPage());
    },
    label: "MP course",
  ),
  CourseCard(
    imageAddress:
        "https://drive.google.com/uc?id=1cVrq9rlVMnCZEFBxfiBXJpmDQc1C3gzv&export=download",
    whenTap: () {
      // Go to C++ Course Page
      Get.to(() => const CppPage());
    },
    label: "C++ course",
  ),
  CourseCard(
    imageAddress:
        "https://media.springernature.com/full/springer-static/cover-hires/book/978-1-4302-0032-1",
    whenTap: () {},
    label: "JAVA course",
  ),
];
List<CourseCard> AdvancedCourses = [
  CourseCard(
    imageAddress:
        "https://media.springernature.com/full/springer-static/cover-hires/book/978-1-4302-0032-1",
    whenTap: () {},
    label: "JAVA course",
  ),
  CourseCard(
    imageAddress:
        "https://drive.google.com/uc?id=1cVrq9rlVMnCZEFBxfiBXJpmDQc1C3gzv&export=download",
    whenTap: () {
      // Go to C++ Course Page
      Get.to(() => const CppPage());
    },
    label: "C++ course",
  ),
  CourseCard(
    imageAddress:
        "https://drive.google.com/uc?id=1HtMKFAWdKdAudHfrKdeol1s92gI4AG7s&export=download",
    whenTap: () {
      Get.to(() => MPAssimplyPage());
    },
    label: "MP course",
  ),
];
