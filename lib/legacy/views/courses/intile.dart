// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

class InTile extends StatelessWidget {
  const InTile({
    super.key,
    required this.end_icon,
    required this.color,
    required this.title,
    required this.onclick, required ,
  });

  final Icon end_icon; // Declare as final to follow best practices
  final String title;
  final VoidCallback onclick;
  final Color color;

  Color getTextColor(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: null,
                style: TextStyle(fontSize: 17,color: getTextColor(context)),
                softWrap: true,
              ),
            ),
            end_icon,
          ],
        ),
      ),
    );
  }
}
