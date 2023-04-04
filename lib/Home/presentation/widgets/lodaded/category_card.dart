import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supermarket_app/Home/data/models/category.dart';
import 'package:supermarket_app/Utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            foregroundImage: NetworkImage(category.imgUrl),
            //onForegroundImageError: ,
            backgroundImage: AssetImage(AppImages.placeholder2),
            //child: Icon(FontAwesomeIcons.shop),
          ),
          // SizedBox(height: 8),
          Text(
            category.name,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
