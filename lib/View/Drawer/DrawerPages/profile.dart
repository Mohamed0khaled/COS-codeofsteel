import 'package:coursesapp/View/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:coursesapp/Auth/AuthView/auth.dart';
import 'package:coursesapp/Auth/AuthController/userdatacontroller.dart';
import 'package:coursesapp/View/Drawer/Drawer.dart';
import 'package:coursesapp/features/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: Remove FirebaseAuth import when fully migrated to AuthCubit
  final User? user = FirebaseAuth.instance.currentUser;
  final UserData _userData = UserData();
  String _username = "Loading...";
  int _score = 0;
  int _level = 0;
  String _rank = "E";
  Color _progressColor = Colors.blue;
  int total_precentage = 0;

  // loading
  bool is_loading = false;

  // control the Scaffold directly.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;
  }

  @override
  void initState() {
    super.initState();
    update();
    _fetchUsername();
    _feachprogdata();
    _changeColor();
  }

  Future<void> update() async {
    setState(() {
      is_loading = true;
    });
    await _userData.updateRankAndLevel();
  }

  Future<void> _changeColor() async {
    _level = await _userData.getLevel();
    _score = await _userData.getScore();
    if (_level == 0) {
      setState(() {
        _progressColor = Colors.lightGreen;
        total_precentage = 10;
      });
    } else if (_level == 1) {
      setState(() {
        _progressColor = Colors.cyan;
        total_precentage = 70;
      });
    } else if (_level == 2) {
      setState(() {
        _progressColor = Colors.amber;
        total_precentage = 150;
      });
    } else if (_level == 3) {
      setState(() {
        _progressColor = Colors.orange;
        total_precentage = 300;
      });
    } else if (_level == 4) {
      setState(() {
        _progressColor = Colors.red;
        total_precentage = 600;
      });
    } else if (_level == 5) {
      setState(() {
        _progressColor = Colors.purple;
        total_precentage = 1000;
      });
    } else if (_level == 6) {
      setState(() {
        _progressColor = Colors.yellowAccent.shade700;
        total_precentage = _score;
        print(total_precentage);
      });
    }
    setState(() {
      is_loading = false;
    });
  }

  Future<void> _feachprogdata() async {
    int score = await _userData.getScore();
    int level = await _userData.getLevel();
    String rank = await _userData.getRank();
    setState(() {
      _score = score;
      _level = level;
      _rank = rank;
    });
  }

  Future<void> _fetchUsername() async {
    String username = await _userData.getUsername();
    setState(() {
      _username = username;
    });
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    showCustomSnackbar(
        title: "Successfully",
        message: "ID copied to clipboard",
        color: _progressColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerPage(),
      body: is_loading
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
          : Stack(
              children: [
                // Top Colored Section (Background)
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.47, // Adjust height
                  decoration: BoxDecoration(
                    color: _progressColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(23),
                      bottomRight: Radius.circular(23),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      // Profile Picture
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.yellow[700],
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: user?.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : null,
                          child: user?.photoURL == null
                              ? const Icon(Icons.person,
                                  size: 50, color: Colors.grey)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Username
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            _username,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Username Editing Dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String newUsername = _username;
                                  return AlertDialog(
                                    title: const Text("Edit Username"),
                                    content: TextField(
                                      decoration: const InputDecoration(
                                        labelText: "Username",
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: TextEditingController(
                                          text: _username),
                                      onChanged: (value) {
                                        newUsername = value;
                                      },
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
                                          if (newUsername.trim().isNotEmpty) {
                                            await _userData
                                                .updateUsername(newUsername);
                                            setState(() {
                                              _username = newUsername;
                                            });
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text("Save"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Circular Progress Indicator Positioned in Center
                Align(
                  alignment: Alignment.center, // Center of the page
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    height: 230,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: getCardColor(context),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Your Progress"),
                        CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 13.0,
                          percent: _score / total_precentage,
                          progressColor: _progressColor,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          animationDuration: 1000,
                          center: Text(
                            "$_score",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Score: $_score"),
                            Text("Level: $_level"),
                            Text("Rank: $_rank"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Positioned(
                    top: 30,
                    left: 10,
                    child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.list_rounded,
                          size: 35,
                        ))),

                // Bottom White Section
                Positioned.fill(
                    top: MediaQuery.of(context).size.height *
                        0.7, // Below the center
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ID: ${_userData.getUserId()}',style: TextStyle(fontWeight: FontWeight.w500),),
                            IconButton(
                                onPressed: () {
                                  copyToClipboard(context, _userData.getUserId());
                                },
                                icon: const Icon(Icons.copy))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            color: _progressColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              // Use AuthCubit for logout
                              context.read<AuthCubit>().logout();
                              Get.offAll(() => const AuthPage());
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
    );
  }
}
