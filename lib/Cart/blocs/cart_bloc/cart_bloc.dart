import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_app/Cart/data/models/cart.dart';
import 'package:supermarket_app/Cart/data/models/cart_item.dart';
import 'package:supermarket_app/Cart/data/repositories/cart_repository.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Cart? cart;
  CartBloc() : super(CartInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CartRepository _cartRepo = locator.get<CartRepository>();
    on<GetCart>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo
            .fetchCart()
            .then((res) =>
                res.fold((left) => emit(CartError(left.message)), (right) {
                  cart = right;
                  emit(CartLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<AddItem>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo.addToCart(event.item).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<RemoveItem>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        // final tempList = cart!.cartContent;
        // tempList.removeWhere((element) => element.id == event.itemId);
        // cart = cart!.copyWith(cartContent: tempList);
        // emit(CartLoaded(cart!));
        await _cartRepo.removeFromCart(event.item).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<CartRemoveCoupon>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo.removeCoupon(event.c).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<CartApplyCoupon>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo.applyCoupon(event.c).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<CartUpdate>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo.updateCart(event.item).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            cart = right;
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<CartAddMultiItems>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo.multiAddCart(event.items).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<SetCart>((event, emit) {
      cart = event.cart;
      emit(CartLoaded(event.cart));
    });
  }
}
