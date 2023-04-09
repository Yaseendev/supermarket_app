import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_app/Cart/data/models/cart.dart';
import 'package:supermarket_app/Cart/data/models/cart_item.dart';
import 'package:supermarket_app/Cart/data/repositories/cart_repository.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';


part 'cart_item_event.dart';
part 'cart_item_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  CartItemBloc() : super(CartItemInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CartRepository _cartRepo = locator.get<CartRepository>();
    on<AddItemToCart>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartItemLoading());
        await _cartRepo.addToCart(event.item).then((res) {
          res.fold((left) => emit(CartItemError(left.message)), (right) {
            emit(CartItemAdded(cart: right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartItemError(error.toString()));
        });
      } else {
        emit(CartItemNoInternet());
      }
    });
  }
}
