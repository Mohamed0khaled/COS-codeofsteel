import 'package:coursesapp/legacy/views/Drawer/DrawerPages/Favourates.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/problemsolving/problemsolving.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/profile.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/saved.dart';
import 'package:coursesapp/legacy/views/Drawer/DrawerPages/setting.dart';
import 'package:coursesapp/legacy/views/homepage.dart';
import 'package:get/get.dart';

class DrawerTap {
  void handleTileTap(int id) {
    switch (id) {
      case 1:
        print("Home Page");
        Get.off(() => const HomePage(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 10));
        break;
      case 2:
        print("Problem solving");
        Get.off(() => const ProblemSolvingPage());
        break;
      case 3:
        print("Favourates");
        Get.off(() => const FavouratesPage());
        break;
      case 4:
        print("Saved");
        Get.off(() => const SavedPage());
        break;
      case 5:
        print("Profile");
        Get.off(() => const ProfilePage());
        break;
      case 6:
        print("Setting");
        Get.off(() => const SettingPage());
        break;
    }
  }
}
