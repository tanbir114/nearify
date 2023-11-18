// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ReplyGroupCard extends StatelessWidget {
  const ReplyGroupCard(
      {Key? key,
      required this.message,
      required this.time,
      required this.senderName})
      : super(key: key);
  final String message;
  final String time;
  final String senderName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // color: Color(0xffdcf8c6),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5, top: 5),
                child: Text(
                  senderName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 50,
                      top: 5,
                      bottom: 10,
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
