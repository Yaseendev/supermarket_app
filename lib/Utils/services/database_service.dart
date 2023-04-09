import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supermarket_app/Account/data/models/name.dart';
import 'package:supermarket_app/Account/data/models/user.dart';
import 'package:supermarket_app/Cart/data/models/cart_item.dart';
import 'package:supermarket_app/Product/data/models/product.dart';

class DatabaseService {
  final FlutterSecureStorage secureStorage;
  DatabaseService([this.secureStorage = const FlutterSecureStorage()]) {
    if (!Hive.isAdapterRegistered(0))
      Hive
        ..registerAdapter(UserAdapter())
        ..registerAdapter(NameAdapter())
        ..registerAdapter(ProductAdapter())
        ..registerAdapter(CartItemAdapter());
  }
}
