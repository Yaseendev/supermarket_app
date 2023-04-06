import 'package:flutter/material.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Utils/constants.dart';

class ProductExploreCard extends StatelessWidget {
  final Product product;
  const ProductExploreCard({super.key,
  required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            foregroundImage: NetworkImage(product.images.first),
            //onForegroundImageError: ,
            backgroundImage: AssetImage(AppImages.placeholder2),
            //child: Icon(FontAwesomeIcons.shop),
          ),
          // SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
