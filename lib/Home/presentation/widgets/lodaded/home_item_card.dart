import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Product/product_bloc/product_bloc.dart';
import 'package:supermarket_app/Utils/constants.dart';

class HomeItemCard extends StatelessWidget {
  final Product product;
  final double width;
  const HomeItemCard({
    super.key,
    required this.product,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(MaterialPageRoute(
      //     builder: (_) => BlocProvider<ProductBloc>(
      //           create: (context) => ProductBloc(product),
      //           child: ProductDetailsScreen(
      //             product: product,
      //           ),
      //         ))),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: product.images.first,
                //'https://offautan-uc1.azureedge.net/-/media/images/off/ph/products-en/products-landing/landing/off_overtime_product_collections_large_2x.jpg?la=en-ph',
                width: width,
                height: 140,
                errorWidget: (context, url, error) => Image.asset(
                  AppImages.placeholder,
                  height: 140,
                  width: width,
                ),
                placeholder: (context, url) => Image.asset(
                  AppImages.placeholder,
                  height: 140,
                  width: width,
                ),
              ),
              SizedBox(height: 5),
              Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(product.desc),
              SizedBox(height: 5),
              Text(
                '${product.price} EGP',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
