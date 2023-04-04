import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_app/Home/data/repositories/home_repository.dart';
import 'package:supermarket_app/Product/data/models/product.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';

part 'deal_event.dart';
part 'deal_state.dart';

class DealBloc extends Bloc<DealEvent, DealState> {
  DealBloc() : super(DealInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final HomeRepository repository = locator.get<HomeRepository>();
    on<FetchDeal>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(DealLoading());
        await repository
            .fetchDealOfDay()
            .then((value) => value.fold((l) => emit(DealError()), (prod) {
                  emit(DealLoaded(prod));
                }));
      }
    });
  }
}
