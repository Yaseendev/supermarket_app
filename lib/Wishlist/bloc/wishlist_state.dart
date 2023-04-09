part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
  
  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistNoInternet extends WishlistState{}

class WishlistError extends WishlistState {
  final String? msg;

  WishlistError([this.msg = 'Something went wrong']);

  @override
  List<Object?> get props => [msg];
}

class WishlistLoaded extends WishlistState {
  final List<Product> products;

  WishlistLoaded(this.products);

  @override
  List<Object?> get props => [products];
}