import 'package:flutter/material.dart';
import 'package:supermarket_app/Cart/data/models/cart.dart';

import 'cart_item_card.dart';
import 'to_checkout_button.dart';

class CartLoadedView extends StatelessWidget {
  final Cart cart;
  const CartLoadedView({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            ...ListTile.divideTiles(
              context: context,
              tiles: cart.cartContent.map((e) => CartItemCard(product: e)),
            ),
            // tempProducts.map((e) => CartItemCard(product: e))),
            // ...state.map((p) => OrderReviewCard(
            //       order: p,
            //     )),
          ],
        ),
        Spacer(),
        // BlocListener<CouponBloc, CouponState>(
        //   listener: (context, cState) {
        //     if (cState is CouponApplied) {
        //       context.read<CartBloc>().add(SetCart(cState.cart));
        //     } else if (cState is CouponFailed) {
        //       ScaffoldMessenger.of(context)
        //           .showSnackBar(SnackBar(content: Text(cState.msg)));
        //     }
        //   },
        //   child: state.cart.coupon == null
        //       ? CouponField(
        //           onApply: (value) {
        //             context
        //                 .read<CouponBloc>()
        //                 .add(ApplyCoupon(couponName: value));
        //           },
        //         )
        //       : CouponCard(state.cart.coupon!),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .19,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sub-total:  ${cart.subtotal} EGP',
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                cart.coupon == null
                    ? Container()
                    : Text(
                        'Disscount:  - ${cart.coupon!.value} EGP',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                Text.rich(TextSpan(
                  text: 'Total:  ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: cart.total.toString() + ' EGP',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )),
                Spacer(),
                ToCheckoutButton(
                  cart: cart,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
