import 'package:flutter/material.dart';
import 'package:frontend/data/dummy_data2.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';
import 'widgets/onlinepeople.dart';

class BlankPage extends StatefulWidget {
  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Hi')
    );
  }
}
