part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductReady extends ProductState {
    final double userRating;

  ProductReady({
    required this.userRating,
  }) : assert(userRating <= 5.0);

  @override
  List<Object> get props => [userRating];
}
