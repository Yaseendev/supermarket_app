// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_item_bloc.dart';

abstract class CartItemState extends Equatable {
  const CartItemState();

  @override
  List<Object?> get props => [];
}

class CartItemInitial extends CartItemState {}

class CartItemLoading extends CartItemState {}

class CartItemNoInternet extends CartItemState {}

class CartItemError extends CartItemState {
  final String? msg;

  CartItemError([this.msg = 'Something went wrong']);

  @override
  List<Object?> get props => [msg];
}

class CartItemAdded extends CartItemState {
  final Cart cart;

  CartItemAdded({
    required this.cart,
  });

  @override
  List<Object?> get props => [cart];
}
