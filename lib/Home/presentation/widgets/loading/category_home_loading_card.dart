import 'package:flutter/material.dart';

class CategoryHomeLoadingCard extends StatelessWidget {
  const CategoryHomeLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
          ),
          SizedBox(height: 5),
          Container(
            height: 11,
            width: 40,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
