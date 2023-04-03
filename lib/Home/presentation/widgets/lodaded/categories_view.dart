import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 30,
        runSpacing: 18,
        children: [
          CategoryCard(),
          CategoryCard(),
          CategoryCard(),
          CategoryCard(),
        ],
      ),
    );
  }
}
