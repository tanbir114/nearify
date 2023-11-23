import 'package:flutter/material.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';

class AddFriend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People You May Know'),
      ),
      body: Consumer<DataProvider2>(
        builder: (context, dataProvider, _) {
          final users = dataProvider.users;

          return ListView.builder(
            itemCount: users?.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/person.svg'), // You may want to update this based on the actual avatar information in your data
                ),
                title: Text(users?[index]['friendName']),
                trailing: ElevatedButton(
                  onPressed: () {
                    dataProvider.toggleFriendRequest(index);
                  },
                  child: Text(
                    users?[index]['isFriendRequestSent']
                        ? 'Cancel Request'
                        : 'Send Request',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
