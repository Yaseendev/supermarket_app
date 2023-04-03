import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../lodaded/home_card.dart';
import 'banner_loading_card.dart';
import 'category_loading_card.dart';
import 'home_loading_card.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BannerLoadingCard(),
              BannerLoadingCard(),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                HomeLoadingCard(),
                HomeLoadingCard(),
              ],
            ),
          ),
          SizedBox(height: 5),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 8,
            //runSpacing: 18,
            children: List.filled(
              12,
              CategoryLoadingCard(),
            ),
          ),
        ],
      ),
    );
  }
}
