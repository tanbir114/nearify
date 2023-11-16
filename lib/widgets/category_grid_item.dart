import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';

class CategoryGridItem extends StatefulWidget {
  final Category category;
  final Function(bool) onSelectChanged;

  CategoryGridItem({Key? key,required this.category, required this.onSelectChanged}): super(key: key);

  @override
  _CategoryGridItemState createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onSelectChanged(_isSelected);
      },
      onLongPress: () {
        // Handle long press logic here if needed
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset(widget.category.img, height: 100, width: 100),
                Text(
                  widget.category.title,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
            _isSelected
                ? const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 32,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
