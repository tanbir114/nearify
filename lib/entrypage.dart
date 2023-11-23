import 'package:flutter/material.dart';
import 'package:frontend/Sign_Up.dart';
import 'package:frontend/login_page.dart';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _entryState();
}

class _entryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        //Image.asset('assets/images/confused2.png', height: 00, width: 250,) ,
        Text(
          'Hold Up! Who are you?',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06, fontWeight: FontWeight.w900),
        ),
        Image.asset(
          'assets/images/confused2.png',
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        const SizedBox(
          height: 20,
          width: 400,
        ),
        const Text(
          'You Might Want to Log In first',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
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
                color: const Color(0xff3237A5),
                borderRadius: BorderRadius.circular(24)),
            padding: const EdgeInsets.all(20),
            child: const Row(
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
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Are you new here?",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
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
                color: const Color(0xff3237A5),
                borderRadius: BorderRadius.circular(24)),
            padding: const EdgeInsets.all(20),
            child: const Row(
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
