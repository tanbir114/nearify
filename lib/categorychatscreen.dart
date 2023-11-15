import 'package:flutter/material.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'All Tags',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 50,
                mainAxisSpacing: 10,
              ),
              children: [
                for (final category in availableCategories)
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
