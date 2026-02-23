import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_controller.dart';
import 'drawer_navigation_handler.dart';

/// Displays the list of drawer navigation categories
class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final DrawerNavigationHandler _navigationHandler = DrawerNavigationHandler();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DrawerNavigationController>(context, listen: true);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: model.pages.length,
            itemBuilder: (context, index) {
              return ListTile(
                selected: model.pages[index].isSelected,
                selectedTileColor: Colors.transparent.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  model.activate(index);
                  Navigator.pop(context); // Close drawer
                  _navigationHandler.handleTileTap(context, index + 1);
                },
                title: Text(model.pages[index].title()),
                leading: model.pages[index].leadingIcon,
              );
            },
          ),
        ),
      ],
    );
  }
}
