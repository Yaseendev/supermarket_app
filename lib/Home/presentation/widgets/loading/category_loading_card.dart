import 'package:flutter/material.dart';

class CategoryLoadingCard extends StatelessWidget {
  const CategoryLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 35,
          ),
        ),
        Container(
          width: 45,
          height: 18,
          color: Colors.grey,
        ),
      ],
    );
  }
}
