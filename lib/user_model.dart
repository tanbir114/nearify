import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/config.dart';
import 'dart:convert';

String? userEmail = '';
String? userName = '';
String? userPhone = '';
String? userPassword = '';
String? userId = '';
List<dynamic>? tags = [];

class DataProvider extends ChangeNotifier {
  Map<String, dynamic>? jsonDataMap;
  Map<String, int>? tagCountMap;
  DataProvider({this.jsonDataMap});

  void changeJsonDataMap({required Map<String, dynamic> newjsonDataMap}) async {
    tagCountMap = {};

    if (newjsonDataMap.containsKey('users')) {
      final users = newjsonDataMap['users'];
      jsonDataMap = newjsonDataMap;
      // print(jsonDataMap);
      for (var user in users) {
        if (user['tagArray'] is List) {
          List<dynamic> tags = user['tagArray'];
          for (var tag in tags) {
            if (tag is String) {
              tagCountMap![tag] = (tagCountMap![tag] ?? 0) + 1;
            }
          }
        }
      }
      notifyListeners();
    }
  }
}

class DataProvider2 extends ChangeNotifier {
  List<dynamic>? people_you_may_know;
  List<dynamic>? get users => people_you_may_know;

  DataProvider2({this.people_you_may_know});

  void changeJsonDataMap({required List<dynamic> new_people_you_may_know}) {
    people_you_may_know = new_people_you_may_know;
    // print(people_you_may_know);
    notifyListeners();
  }

  void toggleFriendRequest(int index) async {
    final bool currentStatus =
        people_you_may_know![index]['isFriendRequestSent'];
    people_you_may_know![index]['isFriendRequestSent'] = !currentStatus;
    notifyListeners();

    var regBody = {
      'userId': people_you_may_know?[index]['userId'].toString(),
      'friendId': people_you_may_know?[index]['friendId'].toString(),
      'requestSent':
          people_you_may_know?[index]['isFriendRequestSent'].toString(),
    };

    await http.post(
      Uri.parse(updatePeopleYouMayKnow),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(regBody),
    );

    print(!currentStatus
        ? 'Friend request sent to ${people_you_may_know![index]['friendName']}'
        : 'Friend request canceled for ${people_you_may_know![index]['friendName']}');
  }
}

class DataProvider3 extends ChangeNotifier {
  List<dynamic>? friends; // Rename 'users' to 'friends'

  List<dynamic>? get users => friends;

  DataProvider3({this.friends});

  void changeJsonData({required List<dynamic> newFriends}) {
    friends = newFriends;
    print(friends);
    notifyListeners();
  }
}
