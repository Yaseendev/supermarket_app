import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supermarket_app/Address/data/models/address.dart';
import 'package:supermarket_app/Address/data/models/location_result.dart';
import 'package:supermarket_app/Utils/services/location_service.dart';
import '../models/network_failure.dart';
import '../providers/location_network_provider.dart';

class LocationRepository {
  late final LocationApiService _apiService;
  //late final LocationDatabaseService _databaseService;
  late final LocationService _locationService;

  LocationRepository({
    required LocationApiService apiService,
    // required LocationDatabaseService databaseService,
    required LocationService locationService,
  }) {
    this._apiService = apiService;
    // this._databaseService = databaseService!;
    this._locationService = locationService;
  }

  // Future<bool> isAddressKnown() async {
  //   return (await _databaseService.getSavedLocations()).isNotEmpty;
  // }

  Future<Position?> getCurrentPosition() async {
    try {
      return await _locationService.determinePosition();
    } catch (e) {
      return null;
    }
  }

  Future<bool> isServiceEnable() async {
    return await _locationService.checkLocationServiceEnabled();
  }

  Future<bool> openLocationSettings() async =>
      await _locationService.openSettings();

  Future<Either<Failure, List<LocationResult>>> getLoactionSearchResult(
      String text) async {
    try {
      List<dynamic> result = await _apiService.searchLocation(text);
      final locationResult =
          result.map((e) => LocationResult.fromJson(e)).toList();
      return Right(locationResult);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, LocationResult?>> getReversedGeoCode(Position position) async {
    try {
      final result = await _apiService.reverseGeoLocation(position);
      final address = result != null ? LocationResult.fromJson(result) : null;
      return Right(address);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  // Future saveLocation(Address location) async =>
  //     await _databaseService.saveLocation(location);

  // Future setCurrentLocation(Address location) async =>
  //     await _databaseService.setCurrentLocation(location);

  // Address? getCurrentLocation() =>
  //     _databaseService.getCurrentLocation();

  // Future<List<Address>> getSavedLocations() async {
  //   return await _databaseService.getSavedLocations();
  // }
}
