import 'package:flutter/material.dart';
import 'package:frontend/data/dummy_data4.dart';
import 'package:frontend/widgets/category_grid_item_chat.dart';
import 'package:frontend/data/dummy_data.dart';
import 'package:frontend/user_model.dart';
import 'package:provider/provider.dart';

class CategoryChatScreen extends StatefulWidget {
  @override
  _CategoryChatScreenState createState() => _CategoryChatScreenState();
}

class _CategoryChatScreenState extends State<CategoryChatScreen> {
  List<String> selectedCategories = ['Exam'];

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
        title: Text('Topics',
        style: TextStyle(
        color: Colors.amberAccent, fontWeight: FontWeight.w900)),
    leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white,),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
          backgroundColor: Color(0xff170746),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Expanded(
            child: ListView(
              children: [
                for (final category in availableTopics)
                  CategoryGridItemChat(
                      category: category,
                      onSelectChanged: (isSelected) {
                        _handleSelectChange(isSelected, category.title);
                      },
                      available: context
                              .watch<DataProvider>()
                              .tagCountMap?[category.title] ??
                          0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}