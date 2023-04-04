import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';
import '../data/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(Product product) : super(ProductInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    //final ProductRepository _productRepo = locator.get<ProductRepository>();

    on<GetProductData>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        //emit(ProductReady(userRating: await _productRepo.getUserRate(product)));
      } else
        emit(ProductReady(userRating: 0));
    });

    on<RateProduct>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
       // await _productRepo.rateProduct(product, event.rate);
      }
    });
  }
}
