import 'package:flutter/material.dart';
import 'package:frontend/Screens/IndividualPage.dart';

class OnlinePeople extends StatefulWidget {
  final String profile;
  final List<dynamic> tags;
  final String id;

  const OnlinePeople(
      {Key? key, required this.profile, required this.tags, required this.id});

  @override
  _OnlineGridItemState createState() => _OnlineGridItemState();
}

class _OnlineGridItemState extends State<OnlinePeople> {
  @override
  Widget build(BuildContext context) {
    String tagstring = widget.tags.join(', ');
    // print("aaaaaaaaaa:" + tagstring);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  IndividualPage(name: widget.profile, id: widget.id)),
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
            color: Colors.blue, // Change the border color
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: Row(
          children: [
            Image.asset('assets/images/online.png', height: 50, width: 50),
            SizedBox(width: MediaQuery.of(context).size.height * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tagstring == ""
                    ? SizedBox(
                        height: MediaQuery.of(context).size.width * 0.022,
                      )
                    : const SizedBox(),
                Text(
                  widget.profile,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 5),
                tagstring != ""
                    ? Text(
                        tagstring,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
