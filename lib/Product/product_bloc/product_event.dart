// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class RateProduct extends ProductEvent {
  final double rate;
  final Product product;

  RateProduct({
    required this.rate,
    required this.product,
  });

  @override
  List<Object> get props => [product, rate];
}

class GetProductData extends ProductEvent {

  @override
  List<Object> get props => [];
}
