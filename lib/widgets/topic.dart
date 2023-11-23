import 'package:flutter/material.dart';
import 'package:frontend/models/topiccard.dart';
import 'package:frontend/onlinescreen.dart';

class Topic extends StatelessWidget {
  const Topic({Key? key, required this.topcard}) : super(key: key);
  final TopicCard topcard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 1.2,
      width: MediaQuery.of(context).size.width * 1.2,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlineScreen(tagName: topcard.title),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  topcard.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xff170746),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 0.2,
                  child: Image.asset(
                    topcard.img,
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  topcard.desc,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
