import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supermarket_app/Account/data/providers/account_db_provider.dart';
import 'package:supermarket_app/Shared/models/network_failure.dart';
import '../models/address.dart';
import '../models/location_result.dart';
import '../provider/address_network_provider.dart';

class AddressRepository {
  late final AddressNetworkProvider _apiService;
  late final AccountDatabaseProvider _accountDatabaseService;

  AddressRepository(
      {required AddressNetworkProvider apiService,
      required AccountDatabaseProvider accountDatabaseService}) {
    this._apiService = apiService;
    
    this._accountDatabaseService = accountDatabaseService;
    
  }

  Future<Either<Failure, List<Address>>> fetchAddresses() async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.getAddresses(token ?? '');
      final addresses =
          result.map((address) => Address.fromMap(address)).toList();
      return Right(addresses);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Address>> addAddress(
    LatLng location,
    String city,
    String street,
    String block,
    String floor,
    String phone,
  ) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.addAddress(
          token ?? '',
          Address(
              position: location,
              city: city,
              street: street,
              blockNumber: block,
              floorNumber: floor,
              phone: phone));
      final address = Address.fromMap(result);
      return Right(address);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Address>> editAddress(Address address) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.editAddress(token ?? '', address);
      final updatedAddress = Address.fromMap(result);
      return Right(updatedAddress);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, bool>> deleteAddress(String id) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.deleteAddress(token ?? '', id);

      return Right(result.first == 'done');
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<List<LocationResult>> getLoactionSearchResult(String text) async {
    List<dynamic> result = await _apiService.searchLocation(text);
    return result.map((e) => LocationResult.fromJson(e)).toList();
  }
}
