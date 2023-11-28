import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
        title: const Text('Friend Requests',
            style: TextStyle(
                color: Colors.amberAccent, fontWeight: FontWeight.w900)),
      ),
      body: Consumer<DataProvider2>(
        builder: (context, dataProvider, _) {
          final friendRequests = dataProvider.users
              ?.where((user) => user['isFriendRequestRecieved'] == true)
              .toList();

          if (friendRequests!.isEmpty) {
            print(friendRequests);
            return const Center(
              child: Text('No friend requests'),
            );
          }

          return ListView.builder(
            itemCount: friendRequests.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/person.svg'),
                ),
                title: Text(friendRequests[index]['friendName']),
                subtitle: const Text('Sent a friend request'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _acceptFriendRequest(dataProvider, index);
                      },
                      child: const Text('Accept'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        _rejectFriendRequest(dataProvider, index);
                      },
                      child: const Text('Reject'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _acceptFriendRequest(DataProvider2 dataProvider, int index) async {
    final friendRequest = dataProvider.users?[index];
    friendRequest['isFriend'] = true;
    friendRequest['isFriendRequestSent'] = false;
    friendRequest['isFriendRequestRecieved'] = false;
    dataProvider.notifyListeners();

    var regBody = {
      'userId': friendRequest['userId'].toString(),
      'friendId': friendRequest['friendId'].toString(),
      'isFriend': friendRequest['isFriend'].toString(),
      'isFriendRequestSent': friendRequest['isFriendRequestSent'].toString(),
      'isFriendRequestRecieved':
          friendRequest['isFriendRequestRecieved'].toString(),
    };

    await http.post(
      Uri.parse(addFriend),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(regBody),
    );

    // ignore: avoid_print
    print('Accepted friend request from ${friendRequest['userName']}');
  }

  Future<void> _rejectFriendRequest(
      DataProvider2 dataProvider, int index) async {
    final friendRequest = dataProvider.users![index];
    friendRequest['isFriendRequestRecieved'] = false;
    friendRequest['isFriendRequestSent'] = false;
    var regBody = {
      'userId': friendRequest['userId'].toString(),
      'friendId': friendRequest['friendId'].toString(),
      'isFriend': friendRequest['isFriend'].toString(),
      'isFriendRequestSent': friendRequest['isFriendRequestSent'].toString(),
      'isFriendRequestRecieved':
          friendRequest['isFriendRequestRecieved'].toString(),
    };
    final response = await http.post(
      Uri.parse(addFriend),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(regBody),
    );

    dataProvider.notifyListeners();

    print('Rejected friend request from ${friendRequest['userName']}');
  }
}
