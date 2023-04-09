import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supermarket_app/Product/data/models/product.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 2)
class CartItem extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final Product product;
  @HiveField(2)
  final int quantity;

  CartItem({
     this.id,
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    Product? product,
    int? qty,
    String? id,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: qty ?? this.quantity,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': id,
      'qty': quantity,
    };
  }

  Map<String, dynamic> toMapForAdd() {
    return <String, dynamic>{
      'id': product.id,
      'qty': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      id: map['key'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CartItem(product: $product, qty: $quantity)';

  @override
  List<Object?> get props => [product, quantity, id];
}
