import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Product/product_bloc/product_bloc.dart';
import 'package:supermarket_app/Utils/constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: product.images.first,
                width: double.maxFinite,
                height: 120,
                placeholder: (context, url) => Image.asset(
                  AppImages.placeholder,
                  width: double.maxFinite,
                  height: 120,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AppImages.placeholder,
                  width: double.maxFinite,
                  height: 120,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              title: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // subtitle: Text(
              //   product.desc,
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              // ),
              trailing: Text(
                '${product.price} EGP',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
