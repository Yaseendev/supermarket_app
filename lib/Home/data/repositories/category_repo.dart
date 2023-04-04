import 'package:dartz/dartz.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Shared/data/models/network_failure.dart';
import '../models/category.dart';
import '../providers/category_network_provider.dart';

class CategoryRepository {
  late final CategoryNetworkProvider _apiService;

  CategoryRepository(CategoryNetworkProvider apiService) {
    this._apiService = apiService;
  }

  Future<Either<Failure, List<Category>>> fetchCategories() async {
    try {
      final result = await _apiService.getCategories();
      final categorise = (result['data'] as List<dynamic>)
          .map((category) => Category.fromMap(category))
          .toList();
      return Right(categorise);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> fetchCategoryProducts(
      int categId) async {
    try {
      final result = await _apiService.getProducts(categId);
      final products = (result['products'] as List<dynamic>)
          .map((product) => Product.fromMap(product))
          .toList();
      return Right(products);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
