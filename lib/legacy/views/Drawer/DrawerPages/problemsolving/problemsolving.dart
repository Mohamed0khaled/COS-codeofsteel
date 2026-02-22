import 'package:coursesapp/legacy/auth/AuthController/userdatacontroller.dart';
import 'package:coursesapp/legacy/views/Drawer/Drawer.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/problemsolving/solvepage.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/profile.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/problemsolving/LevelCard.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class ProblemSolvingPage extends StatefulWidget {
  const ProblemSolvingPage({super.key});

  @override
  State<ProblemSolvingPage> createState() => _ProblemSolvingPageState();
}

class _ProblemSolvingPageState extends State<ProblemSolvingPage> {
  UserData _userData = UserData();
  Color mycolor = Color.fromARGB(255, 0, 97, 50);
  int card_index = 0;
  late int level;
  String programming_language = "C++";

  void GetLevel() {
    if (card_index == 1) {
      level = 0; // E
    } else if (card_index == 0) {
      level = 1; // D
    } else if (card_index == 6) {
      level = 2; // C
    } else if (card_index == 5) {
      level = 3; // B
    } else if (card_index == 4) {
      level = 4; // A
    } else if (card_index == 3) {
      level = 5; // A+
    } else if (card_index == 2) {
      level = 6; // S
    }
  }

  @override
  void initState() {
    super.initState();
    _initializePSPL();
  }

  Future<void> _initializePSPL() async {
    programming_language = await _userData.getUserpspl();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Problem Solving"),
        backgroundColor: mycolor,
        foregroundColor: Colors.white,
      ),
      drawer: const DrawerPage(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 390,
            decoration: BoxDecoration(
                color: mycolor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      "Choose the level that you want to solve problem's on it",
                      style: TextStyle(color: Colors.white),
                    )),

                // here the swiper ////////////////////////
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Swiper(
                        itemCount: 7,
                        layout: SwiperLayout.STACK,
                        itemWidth: double.maxFinite,
                        // Calculate based on available space
                        itemHeight: constraints.maxHeight *
                            0.80, // 85% of available height
                        loop: true,
                        duration: 1200,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          card_index = index;
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * 0.1,
                                horizontal: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(imagepath[index]),
                                  fit: BoxFit.cover,
                                )),
                            width: double.maxFinite,
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Featured",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => ProfilePage());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  Text(
                    " View Profile",
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_circle_right_rounded,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(SettingPage());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.integration_instructions, color: Colors.black),
                  Text(" Programming Lang",
                      style: TextStyle(color: Colors.black)),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade600,
                              offset: Offset(1, 1),
                              spreadRadius: 2,
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-1, -1),
                              spreadRadius: 2,
                              blurRadius: 5),
                        ]),
                    child: Text(programming_language,
                        style: TextStyle(color: Colors.black)),
                  ),
                  Icon(Icons.arrow_circle_right_rounded, color: Colors.black)
                ],
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              print(card_index);
              GetLevel();
              Get.to(() => SolvePage(
                    Level: level,
                    Language_chars: "cpp",
                  ));
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: mycolor, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}
