import 'package:dartz/dartz.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Shared/data/models/network_failure.dart';
import '../providers/home_network_provider.dart';

class HomeRepository {
  late final HomeNetworkProvider _apiService;

  HomeRepository(HomeNetworkProvider apiService) {
    this._apiService = apiService;
    //locator.get<HomeNetworkProvider>();
  }

  Future<Either<Failure, Product>> fetchDealOfDay() async {
    try {
      final result = await _apiService.getDealOfDay();
      final products = (result['products'] as List<dynamic>)
          .map((product) => Product.fromMap(product));
      return Right(products.first);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> fetchPopular() async {
    try {
      final result = await _apiService.getPopularProducts();
      final products = (result['products'] as List<dynamic>)
          .map((product) => Product.fromMap(product));
      return Right(products.toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> fetchTopRatedProducts() async {
    try {
      final result = await _apiService.getTopRatedProducts();
      final products = (result['products'] as List<dynamic>)
          .map((product) => Product.fromMap(product));
      return Right(products.toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
