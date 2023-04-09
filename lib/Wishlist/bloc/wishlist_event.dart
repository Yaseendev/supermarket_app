part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class GetWishList extends WishlistEvent {
  @override
  List<Object> get props => [];
}

class AddToWishlist extends WishlistEvent {
  final Product item;

  AddToWishlist(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromlist extends WishlistEvent {
  final int itemId;

  RemoveFromlist(this.itemId);

  @override
  List<Object> get props => [itemId];
}