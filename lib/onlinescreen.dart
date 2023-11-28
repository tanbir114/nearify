import 'package:flutter/material.dart';
import 'package:frontend/user_model.dart';
import 'package:frontend/widgets/onlinegroup.dart';
import 'package:provider/provider.dart';
import 'widgets/onlinepeople.dart';

class OnlineScreen extends StatefulWidget {
  final String tagName;

  const OnlineScreen({Key? key, required this.tagName}) : super(key: key);

  @override
  _OnlineScreenState createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen> {
  late String desiredTag;

  @override
  void initState() {
    super.initState();
    desiredTag = widget.tagName;
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> onlinePeoples = context
        .watch<DataProvider>()
        .jsonDataMap!['users']
        .where((profile) =>
            profile['tagArray'] != null &&
            (profile['tagArray'] as List).contains(desiredTag))
        .map((profile) => OnlinePeople(
              profile: profile['name'],
              id: profile['_id'],
              tags: profile['tagArray'],
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connect with $desiredTag',
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent),
        ),
        backgroundColor: const Color(
            0xff170746), // Change the color according to your preference
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 9 / 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 10,
              ),
              children: [
                OnlineGroup(groupName: widget.tagName, profiles: onlinePeoples),
                ...onlinePeoples,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
