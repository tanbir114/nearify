import 'package:flutter/material.dart';
import 'package:frontend/add_friend.dart';
import 'package:frontend/anotherhomepage.dart';
import 'package:frontend/chat_page.dart';
import 'package:frontend/user_model.dart';
import 'notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'current_location.dart';
import 'package:geolocator/geolocator.dart';
import 'config.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage(
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userPassword,
    this.userId,
    this.tags, {
    Key? key,
  }) : super(key: key);

  final String? userEmail;
  final String? userName;
  final String? userPhone;
  final String? userPassword;
  final String? userId;
  final List<dynamic>? tags;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  int _currentIndex = 0;
  Timer? timer;

  Map<String, dynamic> updatedjsonDataMap = {};

  var tabs = [
    const AnotherHomePage(),
    Notifications(),
    AddFriend(),
    const ChatPage(),
  ];

  @override
  void initState() {
    super.initState();

    userName = widget.userName;
    userPhone = widget.userPhone;
    userEmail = widget.userEmail;
    userPassword = widget.userPassword;
    userId = widget.userId;
    tags = widget.tags;

    fetchData();

    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) async {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    // var regBody = {
    //   "sourceId": userId!,
    // };

    // var response1 = await http.post(
    //   Uri.parse(PeopleYouMayKnow),
    //   headers: {"Content-type": "application/json"},
    //   body: jsonEncode(regBody),
    // );
    // var updatedPeopleYouMayKnow = json.decode(response1.body);
    // context
    //     .read<DataProvider2>()
    //     .changeJsonDataMap(new_people_you_may_know: updatedPeopleYouMayKnow);

    // response1 = await http.post(
    //   Uri.parse(findFriend),
    //   headers: {"Content-type": "application/json"},
    //   body: jsonEncode(regBody),
    // );

    // var updatedFriends = json.decode(response1.body);
    // context
    //     .read<DataProvider3>()
    //     .changeJsonData(newFriends: updatedFriends?['friends'] ?? []);

    Position position = await CurrentLocation();

    var regBody1 = {
      "email": widget.userEmail!,
      "latitude": position.latitude,
      "longitude": position.longitude,
    };

    final response = await http.post(
      Uri.parse(nearbyusers),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(regBody1),
    );

    updatedjsonDataMap = json.decode(response.body);
    // ignore: use_build_context_synchronously
    context
        .read<DataProvider>()
        .changeJsonDataMap(newjsonDataMap: updatedjsonDataMap);

    await http.post(
      Uri.parse(location),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(regBody1),
    );
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
        backgroundColor: const Color(0xFFF9F9F9),
        body: tabs[_currentIndex], // Pass jsonDataMap here
        bottomNavigationBar: SizedBox(
          height: 72,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            unselectedIconTheme: const IconThemeData(
              size: 24,
            ),
            selectedIconTheme: const IconThemeData(size: 30),
            unselectedItemColor: Colors.white, // Set unselected icon color
            selectedItemColor: Colors.amber,
            backgroundColor: const Color(0xff170746),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_rounded,
                ),
                label: 'Notification',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_add,
                ),
                label: 'AddFriend',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble,
                ),
                label: 'Chat',
                backgroundColor: Colors.white,
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
