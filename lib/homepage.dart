import 'package:flutter/material.dart';
import 'notifications.dart';
import 'notification_model.dart';
import 'message_model.dart';
import 'frontpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'current_location.dart';
import 'package:geolocator/geolocator.dart';
import 'config.dart';

class Homepage extends StatefulWidget {
  Homepage(this.userEmail, {super.key});

  String? userEmail;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  int _currentIndex = 0;
  Timer? timer;

  final tabs = [
    const FrontPage(),
    Notifications('Notifications', notification_model.notification_list,
        message_model.message_list),
    const Center(
      child: Text('Saved'),
    ),
    const Center(
      child: Text('Search'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) async {
      Position position =
          await CurrentLocation(); // Make sure CurrentLocation is properly imported.
      print(position.latitude);
      print(position.longitude);

      var regBody = {
        "email": widget.userEmail,
        "latitude": position.latitude,
        "longitude": position.longitude
      };
      var response = await http.post(Uri.parse(location),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(regBody));

      print('Timer ticked');
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        body: tabs[_currentIndex],
        bottomNavigationBar: SizedBox(
          height: 72,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            unselectedIconTheme: const IconThemeData(
              size: 24,
            ),
            selectedIconTheme: const IconThemeData(size: 30),
            backgroundColor: const Color(0xFFFFFFFF),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_rounded,
                ),
                label: 'Notification',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Saved',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_rounded,
                ),
                label: 'Profile',
                backgroundColor: Colors.blue,
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
