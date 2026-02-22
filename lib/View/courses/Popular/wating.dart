import 'package:flutter/material.dart';

class WatingPage extends StatelessWidget {
  const WatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 0,
          ),
          Container(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "images/work-in-progress.png",
                scale: 3.5,
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              alignment: Alignment.center,
              child: Image.asset(
                "images/sand-clock.png",
                scale: 2.5,
              )),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Text(
              "Coming Soon",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "This course is currently being created. Please wait until the team finishes preparing this course and uploading it to the platform.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Text(
              "We are sorry for your wating ...",
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
