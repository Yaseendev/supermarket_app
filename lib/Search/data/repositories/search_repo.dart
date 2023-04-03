import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Shared/models/network_failure.dart';
import '../providers/search_database_provider.dart';
import '../providers/search_network_provider.dart';

class SearchRepository {
  late final SearchNetworkProvider _apiService;
  // late final AccountDatabaseProvider _accountDatabaseService;
  late final SearchDatabaseProvider _searchDatabaseService;

  SearchRepository(
      {required SearchNetworkProvider apiService,
      required SearchDatabaseProvider searchDatabaseService}) {
    this._apiService = apiService;
    // this._accountDatabaseService = locator.get<AccountDatabaseProvider>();
    this._searchDatabaseService = searchDatabaseService;
    
  }

  Future<Either<Failure, List<Product>>> searchProducts(
    String term, {
    num? minPrice,
    num? maxPrice,
    String? color,
    String? size,
    String? brand,
    String? sale,
    List<String>? categos,
  }) async {
    try {
      final result = await _apiService.search(
        term,
        minPrice,
        maxPrice,
        color,
        size,
        brand,
        sale,
        categos,
      );
      //_searchDatabaseService.saveSearch(term);
      return Right((result['products'] as List<dynamic>)
          .map((e) => Product.fromMap(e))
          .toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  // Future<Either<Failure, ValueListenable<Box<String>>>>
  //     fetchSearchHistory() async {
  //   try {
  //     final searchBox = await _searchDatabaseService.getHistoryBox();
  //     return Right(searchBox.listenable());
  //   } catch (e) {
  //     return Left(Failure('Could not get search history'));
  //   }
  // }
}
