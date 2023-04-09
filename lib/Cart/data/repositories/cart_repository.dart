import 'package:dartz/dartz.dart';
import 'package:supermarket_app/Account/data/providers/account_db_provider.dart';
import 'package:supermarket_app/Shared/data/models/network_failure.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../providers/cart_db_provider.dart';
import '../providers/cart_network_provider.dart';

class CartRepository {
  late final CartNetworkProvider _apiService;
  late final CartDatabaseProvider _databaseService;
  late final AccountDatabaseProvider _accountDatabaseService;

  CartRepository({
    required CartNetworkProvider apiService,
    required CartDatabaseProvider databaseService,
    required AccountDatabaseProvider accountDatabaseService,
  }) {
    this._apiService = apiService;
    this._databaseService = databaseService;
    this._accountDatabaseService = accountDatabaseService;
  }

  Future<Either<Failure, Cart>> fetchCart() async {
    try {
      final token = await _accountDatabaseService.getToken();
      if (token == null) {
        final List<CartItem> cartContent = await _databaseService.fetchCart();
        final total = cartContent.fold(
            0.0,
            (previousValue, element) =>
                previousValue + (element.product.price * element.quantity));
      }
      final result = await _apiService.getCart(token!);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> addToCart(CartItem item) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.addCart(token ?? '', item);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> multiAddCart(List<CartItem> items) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.multiAddCart(token ?? '', items);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> updateCart(CartItem item) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.updateCart(token ?? '', item);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> removeFromCart(String id) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.removeFromCart(token ?? '', id);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> applyCoupon(String c) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.applyCoupon(token ?? '', c);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> removeCoupon(String c) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.removeCoupon(token ?? '', c);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, bool>> checkout(String addressId, String notes) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result =
          await _apiService.checkoutOrder(token ?? '', addressId, notes);
      return Right(true);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
