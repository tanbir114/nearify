import 'package:flutter/material.dart';

class MessageModel {
  String? type;
  String? message;
  String? time;
  String? path;
  String? name;
  MessageModel(
      {required this.type,
      required this.message,
      required this.time,
      required this.path,
      required this.name});
}
