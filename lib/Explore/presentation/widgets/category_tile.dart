import 'package:flutter/material.dart';
import 'package:supermarket_app/Home/data/models/category.dart';
import 'package:supermarket_app/Utils/constants.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final bool selected;
  final VoidCallback onSelect;
  const CategoryTile({
    super.key,
    required this.category,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (!selected) {
          onSelect();
        }
      },
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      selected: selected,
      selectedTileColor: Colors.white,
      leading: Container(
        decoration: BoxDecoration(
            color: selected ? AppColors.PRIMARY_COLOR : null,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(5))),
        width: 8,
      ),
      title: Text(
        category.name,
        textAlign: TextAlign.center,
      ),
    );
  }
}
