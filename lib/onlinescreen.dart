import 'package:flutter/material.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';
import 'widgets/onlinepeople.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({Key? key}) : super(key: key);
  @override
  _OnlinePageState createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Online',
            style: TextStyle(fontSize: 24, color: Colors.white),
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
                for (final profile
                    in context.watch<DataProvider>().jsonDataMap!['users'])
                  OnlineGridItem(
                    profile: profile['name'],
                    id: profile['_id'],
                    tags: profile['tagArray'],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
