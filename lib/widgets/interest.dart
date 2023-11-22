import 'package:flutter/material.dart';
import 'package:frontend/models/interestcard.dart';

class Interest extends StatelessWidget {
  const Interest({super.key, required this.intcard});
  final InterestCard intcard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 140,
      child: Card(
        color: Colors.white,
        elevation: 20,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              
              Image.asset(intcard.img),
              Text(intcard.title),
            ],
          ),
        ),
      ),
    );
  }
}
