part of 'cart_item_bloc.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartItemEvent {
  final CartItem item;
  
  const AddItemToCart({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}
