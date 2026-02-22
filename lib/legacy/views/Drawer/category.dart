import 'package:coursesapp/legacy/controllers/Drawer/drawerController.dart';
import 'package:coursesapp/legacy/controllers/Drawer/drawerTapHandle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  
  final DrawerTap _drawerTap = DrawerTap();

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Drawercontroller>(context, listen: true);
    
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: model.pages.length,
            itemBuilder: (context, index) {
              return ListTile(
                selected: model.pages[index].state,
                selectedTileColor: Colors.transparent.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  model.activate(index);
                  Get.back();
                  _drawerTap.handleTileTap(index + 1);
                },
                title: Text(model.pages[index].title()),
                leading: model.pages[index].leading_icon,
              );
            },
          ),
        ),
        
      ],
    );
  }
}
