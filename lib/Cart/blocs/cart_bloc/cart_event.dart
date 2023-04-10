part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final CartItem item;

  AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItem extends CartEvent {
  final CartItem item;

  RemoveItem(this.item);

  @override
  List<Object> get props => [item];
}

class CartRemoveCoupon extends CartEvent {
  final String c;

  CartRemoveCoupon(this.c);

  @override
  List<Object> get props => [c];
}

class CartApplyCoupon extends CartEvent {
  final String c;

  CartApplyCoupon(this.c);

  @override
  List<Object> get props => [c];
}

class CartUpdate extends CartEvent {
  final CartItem item;

  CartUpdate(this.item);

  @override
  List<Object> get props => [item];
}

class CartAddMultiItems extends CartEvent {
  final List<CartItem> items;

  CartAddMultiItems(this.items);

  @override
  List<Object> get props => [items];
}

class SetCart extends CartEvent {
  final Cart cart;

  SetCart(this.cart);

  @override
  List<Object> get props => [cart];
}
