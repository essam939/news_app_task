import 'package:flutter/material.dart';
import 'package:news/features/news/presentation/widgets/categories_data.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.categoryItem,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.green.shade300 : Colors.grey.shade300,
          ),
          height: 45,
          width: 120,
          child: Center(
            child: Text(categoryItem.name),
          ),
        ),
      ),
    );
  }
}