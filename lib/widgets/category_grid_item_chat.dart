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
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnlinePage()),
          );
        },
        child: Container(
          height: 500,
          child: Card(
            color: Color(0xffffffff),
            elevation: 20,
            child: Padding(
              padding: EdgeInsets.all(16), // Increase padding for more space
              child: Column(
                children: [
                  Text(
                    category.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xff170746),
                    ),
                  ),
                  SizedBox(height: 16), // Increase height between text and image
                  Card(
                    elevation: 0.2,
                    child: Card(
                      //height: 200, // Increase the height of the image container
                      //width: double.infinity, // Take up all available width
                      child: Image.asset(
                        category.img,
                        height: 300,
                        width: 400,
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Increase height between image and text
                  Row(
                    children: [

                      SizedBox(width: 140,),

                      CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.green,
                        ),

                      SizedBox(width: 6,),

                      Text(
                        available.toString(),
                        textAlign: TextAlign.center,
                      ),
                      Text(' Online'),
                    ],
                  ),
                  SizedBox(height: 8), // Increase height between text and bottom

                  Text(
                    category.desc,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
