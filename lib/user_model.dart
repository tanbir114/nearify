import 'package:flutter/material.dart';

String? userEmail = '';
String? userName = '';
String? userPhone = '';
String? userPassword = '';
String? userId = '';

class DataProvider extends ChangeNotifier {
  Map<String, dynamic>? jsonDataMap;
  Map<String, int>? tagCountMap;
  DataProvider({this.jsonDataMap});

  void changeJsonDataMap({required Map<String, dynamic> newjsonDataMap}) async {
    tagCountMap = {};

    if (newjsonDataMap != null && newjsonDataMap.containsKey('users')) {
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
