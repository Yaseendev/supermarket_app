import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:supermarket_app/Cart/data/models/cart_item.dart';
import 'package:supermarket_app/Utils/constants.dart';

class CartItemCard extends StatefulWidget {
  final CartItem product;
  const CartItemCard({
    super.key,
    required this.product,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late int quantity;

  @override
  void initState() {
    quantity = widget.product.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.product.product.images.isNotEmpty ? widget.product.product.images.first : '',
              width: 100,
              height: 90,
              placeholder: (context, url) => Image.asset(
                AppImages.placeholder,
                width: 100,
                height: 90,
              ),
              errorWidget: (context, url, error) => Image.asset(
                AppImages.placeholder,
                width: 100,
                height: 90,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(widget.product.product.name),
              subtitle: Text('${widget.product.product.price} EGP'),
              trailing: SizedBox(
                width: 40 * 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 32,
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () {
                                if (quantity <= 1) {
                                  context
                                      .read<CartBloc>()
                                      .add(RemoveItem(widget.product));
                                } else {
                                  setState(() {
                                    quantity--;
                                  });
                                  context.read<CartBloc>().add(CartUpdate(
                                      widget.product.copyWith(qty: quantity)));
                                }
                              },
                              icon: Icon(Icons.remove),
                              alignment: Alignment.center,
                              iconSize: 18,
                              padding: EdgeInsets.zero,
                              style: IconButton.styleFrom(
                                alignment: Alignment.center,
                                iconSize: 18,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1.5,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.zero,
                            ),
                            alignment: Alignment.center,
                            child: Text(quantity.toString()),
                          ),
                          Container(
                            width: 35,
                            height: 32,
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                                context.read<CartBloc>().add(CartUpdate(
                                    widget.product.copyWith(qty: quantity)));
                              },
                              icon: Icon(Icons.add),
                              alignment: Alignment.center,
                              iconSize: 18,
                              padding: EdgeInsets.zero,
                              style: IconButton.styleFrom(
                                alignment: Alignment.center,
                                iconSize: 18,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
