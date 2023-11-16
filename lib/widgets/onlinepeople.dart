import 'package:flutter/material.dart';
import 'package:frontend/Screens/IndividualPage.dart';
// import 'package:frontend/models/category.dart';
// import 'package:frontend/onlinescreen.dart';
// import 'package:frontend/models/onlineprofiles.dart';

class OnlineGridItem extends StatefulWidget {
  final String profile;
  final List<dynamic> tags;
  final String id;

  const OnlineGridItem({Key? key, required this.profile, required this.tags, required this.id});

  @override
  _OnlineGridItemState createState() => _OnlineGridItemState();
}

class _OnlineGridItemState extends State<OnlineGridItem> {
  @override
  Widget build(BuildContext context) {
    String tagstring = widget.tags.join(', ');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IndividualPage(name: widget.profile, id: widget.id)),
        ).then((_) {
          setState(() {
            // Call setState to refresh the page.
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.yellow,
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Row(
              children: [
                Image.asset('assets/images/online.png', height: 50, width: 50),
                const SizedBox(height: 100, width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 5, width: 50),
                    Text(
                      tagstring,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
