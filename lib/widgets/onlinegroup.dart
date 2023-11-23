import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Screens/GroupScreen.dart';
import 'package:provider/provider.dart';
import 'package:frontend/user_model.dart';

class OnlineGroup extends StatefulWidget {
  final String groupName;
  final List<dynamic> profiles;

  const OnlineGroup({
    Key? key,
    required this.groupName,
    required this.profiles,
  });

  @override
  _OnlineGroupState createState() => _OnlineGroupState();
}

class _OnlineGroupState extends State<OnlineGroup> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> onlineGridItemIds = context
        .watch<DataProvider>()
        .jsonDataMap!['users']
        .where((profile) =>
            profile['tagArray'] != null &&
            (profile['tagArray'] as List).contains(widget.groupName))
        .map((profile) => profile['_id'] as String)
        .toList();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupScreen(
              name: widget.groupName,
              onlineGridItemIds: onlineGridItemIds,
            ),
          ),
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
            color: const Color.fromARGB(255, 33, 54, 243),
          ),
          color: Colors.orangeAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: SvgPicture.asset(
                "assets/groups.svg",
                height: 40,
                width: 40,
                // color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              widget.groupName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
