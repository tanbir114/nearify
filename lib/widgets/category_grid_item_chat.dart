import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/onlinescreen.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';

class CategoryGridItemChat extends StatefulWidget {
  final Category category;
  final Function(bool) onSelectChanged;
  final int available;

  CategoryGridItemChat(
      {Key? key,
      required this.category,
      required this.onSelectChanged,
      required this.available})
      : super(key: key);

  @override
  _CategoryGridItemChatState createState() => _CategoryGridItemChatState();
}

class _CategoryGridItemChatState extends State<CategoryGridItemChat> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 34, 189, 228),
            Color.fromARGB(255, 251, 251, 251)
          ],
        ),
        border: Border.all(color: Color.fromARGB(255, 254, 254, 254)),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Row(
            children: [
              Image.asset(widget.category.img, height: 100, width: 100),
              const SizedBox(height: 100, width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50, width: 50),
                  Text(
                    widget.category.title,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${widget.available.toString()} available users',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OnlineScreen(tagName: widget.category.title)),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.black,
                  iconSize: 36,
                ),
              ]),
            ],
          ),
          _isSelected
              ? const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 32,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
