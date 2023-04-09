import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Cart/blocs/cart_bloc/cart_bloc.dart';
import '../widgets/no_cart_items_view.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback onStart;
  const CartScreen({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return NoCartItemsView(
          onStartPressed: onStart,
        );
      },
    );
  }
}
