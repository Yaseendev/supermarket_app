import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'home_product_loading_card.dart';

class HomeProductsLoadingView extends StatelessWidget {
  const HomeProductsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
        return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.filled(5, HomeProductLoadingCard()),
          ),
        ));
  }
}