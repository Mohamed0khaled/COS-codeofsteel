import 'package:coursesapp/View/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:coursesapp/Auth/AuthView/auth.dart';
import 'package:coursesapp/View/Drawer/Drawer.dart';
import 'package:coursesapp/features/auth/auth.dart';
import 'package:coursesapp/features/user_profile/user_profile.dart';
import 'package:coursesapp/injection_container.dart' as di;
import 'package:coursesapp/core/providers/user_id_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _userId;
  bool _userIdInitialized = false;

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_userIdInitialized) {
      _userId = UserIdProvider.of(context);
      _userIdInitialized = true;
    }
  }

  Color _getProgressColor(int level) {
    switch (level) {
      case 0: return Colors.lightGreen;
      case 1: return Colors.cyan;
      case 2: return Colors.amber;
      case 3: return Colors.orange;
      case 4: return Colors.red;
      case 5: return Colors.purple;
      case 6: return Colors.yellowAccent.shade700;
      default: return Colors.blue;
    }
  }

  void copyToClipboard(BuildContext context, String text, Color color) {
    Clipboard.setData(ClipboardData(text: text));
    showCustomSnackbar(
        title: "Successfully",
        message: "ID copied to clipboard",
        color: color);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => di.sl<ProfileCubit>()..loadProfile(_userId),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerPage(),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
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
            
            if (state is ProfileError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            
            // ProfileLoaded, ProfileUpdating, or ProfileUpdateSuccess
            final profile = state is ProfileLoaded 
                ? state.profile 
                : state is ProfileUpdating 
                    ? state.currentProfile 
                    : (state as ProfileUpdateSuccess).profile;
            
            final progressColor = _getProgressColor(profile.level);
            final totalPercentage = UserProfileEntity.getProgressTarget(profile.level);
            
            return _buildProfileContent(
              context: context,
              profile: profile,
              progressColor: progressColor,
              totalPercentage: totalPercentage,
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent({
    required BuildContext context,
    required UserProfileEntity profile,
    required Color progressColor,
    required int totalPercentage,
  }) {
    return Stack(
      children: [
        // Top Colored Section (Background)
        Container(
          height: MediaQuery.of(context).size.height * 0.47,
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(23),
              bottomRight: Radius.circular(23),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 5),
            children: [
              const SizedBox(height: 60),
              // Profile Picture
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.yellow[700],
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profile.imageUrl != null
                      ? NetworkImage(profile.imageUrl!)
                      : null,
                  child: profile.imageUrl == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
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
                    profile.username,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showEditUsernameDialog(context, profile.username),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Circular Progress Indicator Positioned in Center
        Align(
          alignment: Alignment.center,
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
                  percent: (profile.score / totalPercentage).clamp(0.0, 1.0),
                  progressColor: progressColor,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 1000,
                  center: Text(
                    "${profile.score}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Score: ${profile.score}"),
                    Text("Level: ${profile.level}"),
                    Text("Rank: ${profile.rank}"),
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
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.list_rounded, size: 35),
          ),
        ),

        // Bottom White Section
        Positioned.fill(
          top: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ID: ${profile.id}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    onPressed: () => copyToClipboard(context, profile.id, progressColor),
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () async {
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
          ),
        ),
      ],
    );
  }

  void _showEditUsernameDialog(BuildContext context, String currentUsername) {
    String newUsername = currentUsername;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Edit Username"),
          content: TextField(
            decoration: const InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: currentUsername),
            onChanged: (value) => newUsername = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newUsername.trim().isNotEmpty) {
                  context.read<ProfileCubit>().updateUsername(
                    userId: _userId,
                    newUsername: newUsername,
                  );
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
