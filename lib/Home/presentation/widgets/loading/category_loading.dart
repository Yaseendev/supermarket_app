import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'category_loading_card.dart';

class CategoryLoadingWidget extends StatelessWidget {
  const CategoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        children: List.filled(6, CategoryLoadingCard()),
      ),
    );
  }
}
