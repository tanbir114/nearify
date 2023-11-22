import 'package:flutter/material.dart';
import 'package:frontend/Sign_Up.dart';
import 'package:frontend/login_page.dart';

class entry extends StatefulWidget {
  const entry({super.key});

  @override
  State<entry> createState() => _entryState();
}

class _entryState extends State<entry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        //Image.asset('assets/images/confused2.png', height: 00, width: 250,) ,
        Text(
          'Hold Up! Who are you?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        Image.asset(
          'assets/images/confused2.png',
          height: 150,
          width: 250,
        ),
        SizedBox(
          height: 20,
          width: 400,
        ),
        Text(
          'You Might Want to Log In first',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Container(
            width: 330,
            decoration: BoxDecoration(
                color: Color(0xff3237A5),
                borderRadius: BorderRadius.circular(24)),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Log In',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Are you new here?",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
          child: Container(
            width: 330,
            decoration: BoxDecoration(
                color: Color(0xff3237A5),
                borderRadius: BorderRadius.circular(24)),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
