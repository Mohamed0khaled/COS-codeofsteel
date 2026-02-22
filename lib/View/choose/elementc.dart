// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

class MoTile extends StatefulWidget {
  MoTile(
      {super.key,
      required this.start_icon,
      required this.title,
      required this.onclick});

  Icon start_icon;
  String title;
  VoidCallback onclick;

  @override
  State<MoTile> createState() => _MoTileState();
}

class _MoTileState extends State<MoTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onclick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.start_icon, // Use widget.start_icon here
                const SizedBox(width: 7),
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
            const Icon(Icons.arrow_circle_right),
          ],
        ),
      ),
    );
  }
}
