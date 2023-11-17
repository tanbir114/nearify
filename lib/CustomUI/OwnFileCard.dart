import 'dart:io';

import 'package:flutter/material.dart';

class OwnFileCard extends StatelessWidget {
  const OwnFileCard({
    Key? key,
    required this.path,
    required this.message,
    required this.time,
  }) : super(key: key);

  final String path;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showFullImage(context);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.8,
            ),
            child: Card(
              margin: const EdgeInsets.all(3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.file(
                      File(path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                  if (message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
