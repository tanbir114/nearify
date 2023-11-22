import 'package:flutter/material.dart';
import 'package:frontend/models/topiccard.dart';
import 'package:frontend/onlinescreen.dart';
import 'package:get/get.dart';

class Topic extends StatelessWidget {
  const Topic({super.key, required this.topcard});
  final TopicCard topcard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 420,
      child: GestureDetector(
        onTap: (){
          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnlinePage()),
                    );
        },
        child: Card(
          color: Color(0xffffffff),
          elevation: 20,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
      
                Text(topcard.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff170746)),),
                SizedBox(height: 10,),
                Card(
                  elevation: 0.2,
                  child: Image.asset(
                    topcard.img,
                    height: 300,
                    width: 400,
                  ),
                ),
                SizedBox(height: 15,),
                Text(topcard.desc, textAlign: TextAlign.center,),
                SizedBox(height: 5,),
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}
