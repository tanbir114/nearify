import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddFriend extends StatefulWidget {
  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
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
        Uri.parse(PeopleYouMayKnow),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(regBody),
      );
      var updatedPeopleYouMayKnow = json.decode(response1.body);
      context
          .read<DataProvider2>()
          .changeJsonDataMap(new_people_you_may_know: updatedPeopleYouMayKnow);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff170746),
        title: Text('People You May Know',
            style: TextStyle(
                color: Colors.amberAccent, fontWeight: FontWeight.w900)),
      ),
      body: Consumer<DataProvider2>(
        builder: (context, dataProvider, _) {
          final users = dataProvider.users;

          return ListView.builder(
            itemCount: users?.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/person.svg'),
                ),
                title: Text(users?[index]['friendName']),
                trailing: ElevatedButton(
                  onPressed: () {
                    dataProvider.toggleFriendRequest(index);
                  },
                  child: Text(
                    users?[index]['isFriendRequestSent']
                        ? 'Cancel Request'
                        : 'Send Request',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
