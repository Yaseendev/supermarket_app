import 'dart:convert';
import 'cart_item.dart';
import 'coupon.dart';

class Cart {
  final List<CartItem> cartContent;
  final double total;
  final double subtotal;
  final Coupon? coupon;

  Cart({
    required this.cartContent,
    required this.total,
    required this.subtotal,
    this.coupon,
  });

  Cart copyWith({
    List<CartItem>? cartContent,
    double? total,
    double? subtotal,
    Coupon? coupon,
  }) {
    return Cart(
      cartContent: cartContent ?? this.cartContent,
      total: total ?? this.total,
      subtotal: subtotal ?? this.subtotal,
      coupon: coupon ?? this.coupon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartContent': cartContent,
      'total': total,
      'subtotal': subtotal,
      'coupon': coupon,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartContent: (map['cart_contents'] as List<dynamic>)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      total: double.parse(map['_total'].toString().replaceAll(',', '')),
      subtotal: double.parse(map['_subtotal'].toString().replaceAll(',', '')),
      coupon: map['coupon_discount_totals'] is List<dynamic>
          ? null
          : Coupon.fromMap(map['coupon_discount_totals']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(cartContent: $cartContent, total: $total, subtotal: $subtotal)';
  }
}
