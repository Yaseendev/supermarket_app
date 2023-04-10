import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supermarket_app/Cart/data/models/cart_item.dart';
import '../Account/data/models/user.dart';

class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFF146C94);
  static const Color BACKGROUND_COLOR = Color(0xFFF7F8F9);
  // ignore: non_constant_identifier_names
  static final MaterialColor PRIMARY_SWATCH =
      MaterialColor(AppColors.PRIMARY_COLOR.value, <int, Color>{
    50: PRIMARY_COLOR,
    100: PRIMARY_COLOR,
    200: PRIMARY_COLOR,
    300: PRIMARY_COLOR,
    400: PRIMARY_COLOR,
    500: PRIMARY_COLOR,
    600: PRIMARY_COLOR,
    700: PRIMARY_COLOR,
    800: PRIMARY_COLOR,
    900: PRIMARY_COLOR,
  });
}

class AppImages {
  static const String rootUri = 'assets/images';
  static const String logoTransparent = '$rootUri/logo_transparent.png';
  static const String logo = '$rootUri/logo.png';
  static const String defaultProfile = '$rootUri/default_profile.png';
  static const String placeholder = '$rootUri/placeholder.jpg';
  static const String placeholder2 = '$rootUri/placeholder_thumb.jpg';
  static const String emptyCart = '$rootUri/empty-cart.svg';
}

class Boxes {
  static Future<Box<User>> getUserBox() async {
    if (Hive.isBoxOpen('userBox'))
      return Hive.box<User>('userBox');
    else
      return await Hive.openBox<User>('userBox');
  }

  static Future<Box<String>> getSearchBox() async {
    if (Hive.isBoxOpen('searchHistory'))
      return Hive.box<String>('searchHistory');
    else
      return await Hive.openBox<String>('searchHistory');
  }

  static Future<Box<CartItem>> getCartBox() async {
    if (Hive.isBoxOpen('Cart'))
      return Hive.box<CartItem>('Cart');
    else
      return await Hive.openBox<CartItem>('Cart');
  }
}

enum PaymentMethod { cash, creditCard }

class Urls {
  static const String DOMAIN = 'https://market.almotawer.net';
  static const String LOCATION_DOMAIN = 'https://eu1.locationiq.com';
  static const String LOCATION_BASE_API = LOCATION_DOMAIN + '/v1';
  static const String BASE_API = DOMAIN + '/wp-json/woo';
  static const String AUTH_PATH = '/auth';
  static const String CART_PATH = '/cart';
  static const String ADDRESS_PATH = '/address';
  static const String WISHLIST_PATH = '/wishlist';
  static const String PRODUCT_PATH = '/products';
  static const String SIGNUP_API = '$AUTH_PATH/register';
  static const String SIGNIN_API = '$AUTH_PATH/login';
  static const String FORGOTPASS_API = '$AUTH_PATH/forgot_password';
  static const String GET_CATEGORIES = '/cat/home';
  static const String SEARCH = '/search';
  static const String GET_CART = '$CART_PATH/list';
  static const String ADD_CART = '$CART_PATH/add';
  static const String ADD_MULTI_CART = '$CART_PATH/add_multiple';
  static const String UPDATE_CART = '$CART_PATH/update';
  static const String REMOVE_CART = '$CART_PATH/remove';
  static const String APPLY_COUP_CART = '$CART_PATH/apply_coupon';
  static const String REMOVE_COUP_CART = '$CART_PATH/remove_coupon';
  static const String ADD_ADDRESS = '$ADDRESS_PATH/add';
  static const String EDIT_ADDRESS = '$ADDRESS_PATH/update';
  static const String GET_ADDRESSES = '$ADDRESS_PATH/list';
  static const String DELETE_ADDRESS = '$ADDRESS_PATH/delete';
  static const String GET_WISHLIST = '$WISHLIST_PATH/list';
  static const String ADD_WISHLIST = '$WISHLIST_PATH/add';
  static const String REMOVE_WISHLIST = '$WISHLIST_PATH/remove';
  static const String CHECKOUT = '/checkout';
  static const String GET_PRODUCTS = '$PRODUCT_PATH/byid';

  ///Location Urls
  static const String LOCATION_AUTOCOMPLETE = '/autocomplete.php';
  static const String LOCATION_REVERSE = '/reverse.php';
}

const String locationKey = 'pk.0b821f869258d4129c196400ab4927f0';
