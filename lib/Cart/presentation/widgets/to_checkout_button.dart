import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:supermarket_app/Cart/data/models/cart.dart';
import '../screens/checkout_screen.dart';

class ToCheckoutButton extends StatelessWidget {
  final Cart cart;
  const ToCheckoutButton({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
            ),
            onPressed: state is CartLoading
                ? null
                : () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => BlocProvider<CheckoutBloc>(
                    //           create: (context) => CheckoutBloc(),
                    //           child: CheckoutScreen(
                    //             cart: cart,
                    //           ),
                    //         )));
                    //context.read<CartBloc>()
                  },
            child: state is CartLoading
                ? Center(
                    child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ))
                : const Text(
                    'Procceed to checkout',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
