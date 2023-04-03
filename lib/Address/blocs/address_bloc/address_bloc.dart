import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supermarket_app/Address/data/models/address.dart';
import 'package:supermarket_app/Address/data/repositories/address_repo.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AddressRepository _addressRepository =
        locator.get<AddressRepository>();

    on<AddAddress>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressLoading());
        await _addressRepository
            .addAddress(event.location, event.city, event.street, event.block,
                event.floor, event.phone)
            .then((res) {
          res.fold((left) => emit(AddressError(left.message)), (right) {
            //_addresses.add(right);
            emit(AddressAdded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(AddressError(error.toString()));
        });
      } else {
        emit(AddressNoInternet());
      }
    });

    on<EditAddress>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressLoading());
        await _addressRepository.editAddress(event.address).then((res) {
          res.fold((left) => emit(AddressError(left.message)), (right) {
            emit(AddressEdited(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(AddressError(error.toString()));
        });
      } else {
        emit(AddressNoInternet());
      }
    });

    on<DeleteAddress>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressLoading());
        await _addressRepository.deleteAddress(event.id).then((res) {
          res.fold((left) => emit(AddressError(left.message)), (right) {
            emit(AddressDeleted(event.id));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(AddressError(error.toString()));
        });
      } else {
        emit(AddressNoInternet());
      }
    });
  }
}
