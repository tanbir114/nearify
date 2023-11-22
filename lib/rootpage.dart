import 'package:flutter/material.dart';
import 'package:frontend/login_page.dart';
import 'package:frontend/Sign_Up.dart';
import 'package:frontend/entrypage.dart';

class rootPage extends StatefulWidget {
  const rootPage({Key? key}) : super(key: key);

  @override
  State<rootPage> createState() => _rootPageState();
}

class _rootPageState extends State<rootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/camp.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // Replace with the actual path to your image
          ),

          // Overlay Widgets

          const Positioned(
            top: 150.0, // Adjust the position of the text
            left: 20.0, // Adjust the position of the text
            child: Text(
              'CONNECT\nLIKE\nNEVER\nBEFORE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          Positioned(
            bottom: 30.0,
            left: 10, // Adjust the position of the button
            // Adjust the position of the button
            child: GestureDetector(
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );*/
                showModalBottomSheet(
                    context: context, builder: (ctx) => entry());
              },
              child: Container(
                width: 370,
                decoration: BoxDecoration(
                    color: Color(0xff3237A5),
                    borderRadius: BorderRadius.circular(24)),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'START DISCOVERING',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
