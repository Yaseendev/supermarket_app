import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          foregroundImage: NetworkImage(
              'https://img.freepik.com/free-vector/mega-sale-offers-banner-template_1017-31299.jpg?w=2000'),
          //onForegroundImageError: ,
          child: Icon(Icons.shop),
        ),
        SizedBox(height: 8),
        Text(
          'Test',
          maxLines: 2,
        ),
      ],
    );
  }
}
