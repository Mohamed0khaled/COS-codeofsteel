import 'package:coursesapp/View/Drawer/Drawer.dart';
import 'package:flutter/material.dart';

class CWMPage extends StatelessWidget {
  const CWMPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Contact With Me"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      drawer: const DrawerPage(),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 90, 
              backgroundColor: Colors.transparent,
              child: Image.asset("images/logo.png"),
            ),
          ),
          
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: const Text("Contact Via",style: TextStyle(fontSize: 30,color: Colors.black),),
          ),
          const SizedBox(height: 25,),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.contact_emergency_sharp),
                SizedBox(width: 20,),
                Text("Contact Via Email",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.contact_emergency_sharp),
                SizedBox(width: 20,),
                Text("Contact Via WhatsApp",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.contact_emergency_sharp),
                SizedBox(width: 20,),
                Text("Contact Via Facebook",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.contact_emergency_sharp),
                SizedBox(width: 20,),
                Text("Contact Via GitHub",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.contact_emergency_sharp),
                SizedBox(width: 20,),
                Text("Contact Via Instagram",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.contact_emergency_sharp),
                SizedBox(width: 20,),
                Text("Contact Via Telegram",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
