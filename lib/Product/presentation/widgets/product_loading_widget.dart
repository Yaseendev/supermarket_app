import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'product_loading_card.dart';

class ProductLoadingWidget extends StatelessWidget {
  const ProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        children: List.filled(8, ProductLoadingCard()),
      ), 
    );
  }
}