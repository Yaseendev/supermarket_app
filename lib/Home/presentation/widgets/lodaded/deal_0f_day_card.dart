import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Utils/constants.dart';

class DealOfTheDayCard extends StatelessWidget {
  final Product product;
  const DealOfTheDayCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: product.images.first,
                //'https://m.media-amazon.com/images/I/61UY5LzzA0L._AC_UF1000,1000_QL80_.jpg',
                alignment: Alignment.center,
                height: 180,
                width: double.maxFinite,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/placeholder.jpg',
                  height: 180,
                ),
                fit: BoxFit.contain,
                placeholder: (context, url) => Image.asset(
                  'assets/images/placeholder.jpg',
                  height: 180,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                // 'Apple Macbook Pro M2',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: product.regularPrice.toString() + ' EGP',
                  //'70,000.00',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                  children: [
                    TextSpan(
                      text: '   ${product.salePrice} EGP',
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
