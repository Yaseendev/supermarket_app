import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'category_home_loading_card.dart';

class CategoriesLoadingView extends StatelessWidget {
  const CategoriesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 20,
        runAlignment: WrapAlignment.spaceBetween,
        children: List.filled(15, CategoryHomeLoadingCard()),
      ),
      // SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
      //   physics: NeverScrollableScrollPhysics(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: List.filled(5, CategoryHomeLoadingCard()),
      //   ),
      // )
    );
  }
}
