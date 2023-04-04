import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DealLoadingCard extends StatelessWidget {
  const DealLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 250,
          ),
        ),
      ),
    );
  }
}
