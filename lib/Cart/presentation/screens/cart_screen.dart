import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supermarket_app/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:supermarket_app/Utils/constants.dart';
import '../widgets/cart_loaded_view.dart';
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
      buildWhen: (previous, current) => current is! CartError && current is! CartContentLoading,
      builder: (context, state) {
        if(state is CartLoaded && state.cart.cartContent.isNotEmpty){
          return CartLoadedView(
            cart: state.cart,
          );
        } else if(state is CartLoading) {
          return Center(
          child: SpinKitFadingCube(
            color: AppColors.PRIMARY_COLOR,
            size: 58,
          ),
        );
        }
        return NoCartItemsView(
          onStartPressed: onStart,
        );
      },
    );
  }
}
