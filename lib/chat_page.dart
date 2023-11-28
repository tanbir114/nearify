import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';
import 'widgets/onlinepeople.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    fetchData();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      fetchData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      var regBody = {
        "sourceId": userId!,
      };
      var response1 = await http.post(
        Uri.parse(findFriend),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(regBody),
      );

      var updatedFriends = json.decode(response1.body);
      context
          .read<DataProvider3>()
          .changeJsonData(newFriends: updatedFriends?['friends'] ?? []);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> onlinePeoples = context
            .watch<DataProvider3>()
            .friends
            ?.where(
                (profile) => profile['_id'] != null) // Ensure _id is not null
            .map((profile) => OnlinePeople(
                  profile: profile['name'],
                  id: profile['_id'],
                  tags: const [],
                ))
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inbox',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent),
        ),
        backgroundColor: const Color(
            0xff170746), // Change the color according to your preference
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 9 / 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 10,
              ),
              children: [
                ...onlinePeoples,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
