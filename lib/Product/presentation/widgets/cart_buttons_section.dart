import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:supermarket_app/Cart/blocs/cart_item_bloc/cart_item_bloc.dart';

class CartButtonsSection extends StatelessWidget {
  final Function(BuildContext ctx) onPress;
  const CartButtonsSection({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartItemBloc, CartItemState>(
      listener: (context, state) {
        if (state is CartItemAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product added to your cart')));
          context.read<CartBloc>().add(SetCart(state.cart));
        } else if (state is CartItemError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg ?? 'Something went wrong')));
        } else if (state is CartItemNoInternet) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('No Internet Connection')));
        }
      },
      child: Material(
        elevation: 35,
        type: MaterialType.card,
        borderOnForeground: true,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CartItemBloc, CartItemState>(
            builder: (context, state) {
              return SizedBox(
                height: 48,
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state is! CartItemLoading
                      ? () {
                          onPress(context);
                        }
                      : null,
                  label: Text(
                    'Add To Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: state is! CartItemLoading
                      ? Icon(Icons.add_shopping_cart_rounded)
                      : Center(
                          child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
