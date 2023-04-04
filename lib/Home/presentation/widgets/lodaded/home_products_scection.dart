import 'package:flutter/material.dart';
import 'package:supermarket_app/Product/data/models/product.dart';

import 'home_item_card.dart';

class HomeProductsSection extends StatelessWidget {
  final List<Product> products;
  const HomeProductsSection({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // padding: const EdgeInsets.symmetric(horizontal: 14),
        // scrollDirection: Axis.horizontal,
        // shrinkWrap: true,
        children: products.map((product) => HomeItemCard(
          product: product,
          width: 150,
        )).toList(), 
      ),
    );
  }
}
