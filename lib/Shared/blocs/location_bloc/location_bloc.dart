import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supermarket_app/Address/data/models/address.dart';
import 'package:supermarket_app/Address/data/models/location_result.dart';
import 'package:supermarket_app/Shared/data/repositories/location_repository.dart';
import 'package:supermarket_app/Utils/services/service_locator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final LocationRepository locationRepo = locator.get<LocationRepository>();
    on<DetectCurrentLocation>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          final Position? position = await locationRepo.getCurrentPosition();
          if (position != null) {
            await locationRepo
                .getReversedGeoCode(position)
                .then((res) => res.fold(
                  (l) => emit(LocationError()),
                  (location) => emit(
                    location == null ? LocationError() :
                    LocationDetected(currentLocation: location))))
                .onError((error, stackTrace) => emit(LocationError()));
          } else {
            emit(LocationError());
          }
        } catch (e) {
          emit(LocationError());
        }
      } else {
        emit(LocationError());
      }
    });
  }
}
