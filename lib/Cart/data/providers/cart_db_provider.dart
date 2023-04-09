import 'package:hive_flutter/hive_flutter.dart';
import 'package:supermarket_app/Cart/data/models/cart_item.dart';
import 'package:supermarket_app/Utils/constants.dart';
import 'package:supermarket_app/Utils/services/database_service.dart';

class CartDatabaseProvider extends DatabaseService {
  late final Box<CartItem>? _cartBox;
  CartDatabaseProvider(super.secureStorage) : super();

  Future<void> addToCart(CartItem item) async {
    if (_cartBox == null) _cartBox = await Boxes.getCartBox();
    if (_cartBox!.containsKey(item.product.id)) {
      await _cartBox!
          .putAt(int.parse(item.id!), item.copyWith(qty: item.quantity + 1));
    } else {
      final index = await _cartBox!.add(item);
      await _cartBox!.putAt(index, item.copyWith(id: index.toString()));
    }
  }

  Future<void> removeFromCart(CartItem item) async {
    if (_cartBox == null) _cartBox = await Boxes.getCartBox();
    await _cartBox!.deleteAt(int.parse(item.id!));
  }

  Future<void> increaseQuantity(CartItem item) async {
    if (_cartBox == null) _cartBox = await Boxes.getCartBox();
    await _cartBox!
        .putAt(int.parse(item.id!), item.copyWith(qty: item.quantity + 1));
  }

  Future<void> decreaseQuantity(CartItem item) async {
    if (_cartBox == null) _cartBox = await Boxes.getCartBox();
    if (item.quantity == 1) {
      await _cartBox!.deleteAt(int.parse(item.id!));
    }
    await _cartBox!
        .putAt(int.parse(item.id!), item.copyWith(qty: item.quantity - 1));
  }

    Future<List<CartItem>> fetchCart() async {
    if (_cartBox == null) _cartBox = await Boxes.getCartBox();

     return _cartBox!.values.toList();
  }
}
