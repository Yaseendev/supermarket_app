import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';
import '../data/repositories/wishlist_repo.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final WishlistRepository _wishlistRepository =
        locator.get<WishlistRepository>();

    on<GetWishList>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(WishlistLoading());
        await _wishlistRepository
            .fetchWishlist()
            .then((res) =>
                res.fold((left) => emit(WishlistError(left.message)), (right) {
                  emit(WishlistLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(WishlistError(error.toString()));
        });
      } else {
        emit(WishlistNoInternet());
      }
    });

    on<AddToWishlist>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(WishlistLoading());
        await _wishlistRepository
            .addToList(event.item.id.toString())
            .then((res) =>
                res.fold((left) => emit(WishlistError(left.message)), (right) {
                  emit(WishlistLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(WishlistError(error.toString()));
        });
      } else {
        emit(WishlistNoInternet());
      }
    });

    on<RemoveFromlist>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(WishlistLoading());
        await _wishlistRepository
            .removeFromList(event.itemId)
            .then((res) =>
                res.fold((left) => emit(WishlistError(left.message)), (right) {
                  emit(WishlistLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(WishlistError(error.toString()));
        });
      } else {
        emit(WishlistNoInternet());
      }
    });
  }
}
