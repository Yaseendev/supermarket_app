import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_app/Home/data/repositories/category_repo.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CategoryRepository categoryRepository =
        locator.get<CategoryRepository>();
    final List<Product> _products = [];
    on<LoadCategory>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CategoryLoading());
        await categoryRepository
            .fetchCategoryProducts(event.categoryId)
            .then((value) => value.fold((l) => null, (prods) {
                  _products
                    ..clear()
                    ..addAll(prods);
                  emit(CategoryLoaded(products: prods));
                }));
      }
    });

    on<FillterProducts>((event, emit) {
      if (_products.isNotEmpty) {
        emit(
          CategoryLoaded(products: event.searchTerm.isEmpty ? _products : _products.where((element) => element.name.contains(event.searchTerm) || element.desc.contains(event.searchTerm)).toList(),
          searchTerm: event.searchTerm,
          ));
      }
    });
  }
}
