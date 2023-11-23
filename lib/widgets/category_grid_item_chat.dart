import 'package:flutter/material.dart';
import 'package:frontend/models/topiccard.dart';
import 'package:frontend/onlinescreen.dart';

class CategoryGridItemChat extends StatelessWidget {
  final TopicCard category;
  final Function(bool) onSelectChanged;
  final int available;

  CategoryGridItemChat({
    required this.category,
    required this.onSelectChanged,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlineScreen(tagName: category.title),
            ),
          );
        },
        child: SizedBox(
          width: double.infinity, // Take up all available width
          child: Card(
            color: const Color(0xffffffff),
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      category.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff170746),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        category.img,
                        height: 200, // Set the desired height for the image
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.green,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$available Online',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      category.desc,
                      textAlign: TextAlign.center,
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
}
