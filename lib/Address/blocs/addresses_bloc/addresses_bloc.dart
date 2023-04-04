import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supermarket_app/Address/data/models/address.dart';
import 'package:supermarket_app/Address/data/repositories/address_repo.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(AddressesInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AddressRepository _addressRepository =
        locator.get<AddressRepository>();
    final List<Address> _addresses = [];
    Address? selectedAddress;

    on<GetAllAddresses>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressesLoading());
        await _addressRepository
            .fetchAddresses()
            .then((res) =>
                res.fold((left) => emit(AddressesError(left.message)), (right) {
                  _addresses
                    ..clear()
                    ..addAll(right);
                  if (_addresses.isNotEmpty) selectedAddress = right.first;
                  emit(AddressesFetched(
                    addresses: right,
                    selectedAddress: selectedAddress,
                  ));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(AddressesError(error.toString()));
        });
      } else {
        emit(AddressesNoInternet());
      }
    });


    on<SetSelectedAddress>((event, emit) async {
      emit(AddressesFetched(
        addresses: _addresses,
        selectedAddress: event.address,
      ));
    });
  }

  @override
  void onChange(Change<AddressesState> change) {
    print(change);
    super.onChange(change);
  }
}
