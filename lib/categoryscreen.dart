import 'package:flutter/material.dart';
import 'package:frontend/login_page.dart';
import 'package:frontend/widgets/category_grid_item.dart';
import 'package:frontend/data/dummy_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, this.userEmail}) : super(key: key);
  String? userEmail;
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> selectedCategories = [];

  void tag_update() async {
    try {
      var regBody = {
        "email": widget.userEmail,
        "tagArray": selectedCategories,
      };
      var response = await http.post(Uri.parse(tagUpdate),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  void _handleSelectChange(bool isSelected, String categoryTitle) {
    setState(() {
      if (isSelected) {
        selectedCategories.add(categoryTitle);
      } else {
        selectedCategories.remove(categoryTitle);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Tags'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              children: [
                for (final category in availableCategories)
                  CategoryGridItem(
                    category: category,
                    onSelectChanged: (isSelected) {
                      _handleSelectChange(isSelected, category.title);
                    },
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              tag_update();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
            ),
            child: const SizedBox(
              width: double
                  .infinity, // Expands the width of the button to the maximum available width
              height: 60, // Sets the height of the button to 60 logical pixels

              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
