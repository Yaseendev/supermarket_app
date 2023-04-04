import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:supermarket_app/Account/data/providers/account_db_provider.dart';
import 'package:supermarket_app/Account/data/providers/account_network_provider.dart';
import 'package:supermarket_app/Account/data/repositories/account_repo.dart';
import 'package:supermarket_app/Address/data/provider/address_network_provider.dart';
import 'package:supermarket_app/Address/data/repositories/address_repo.dart';
import 'package:supermarket_app/Home/data/providers/category_network_provider.dart';
import 'package:supermarket_app/Home/data/providers/home_network_provider.dart';
import 'package:supermarket_app/Home/data/repositories/category_repo.dart';
import 'package:supermarket_app/Home/data/repositories/home_repository.dart';
import 'package:supermarket_app/Search/data/providers/search_database_provider.dart';
import 'package:supermarket_app/Search/data/providers/search_network_provider.dart';
import 'package:supermarket_app/Search/data/repositories/search_repo.dart';
import 'package:supermarket_app/Shared/data/providers/location_network_provider.dart';
import 'package:supermarket_app/Shared/data/repositories/location_repository.dart';
import 'database_service.dart';
import 'location_service.dart';

final locator = GetIt.instance;

Future locatorsSetup() async {
  final database = DatabaseService();

  locator
    ..registerLazySingleton<Connectivity>(() => Connectivity())
    ..registerLazySingleton<AccountNetworkProvider>(
        () => AccountNetworkProvider());
  locator.registerLazySingleton<AccountDatabaseProvider>(
      () => AccountDatabaseProvider(database.secureStorage));
  locator.registerLazySingleton<AccountRepository>(() => AccountRepository(
      locator.get<AccountNetworkProvider>(),
      locator.get<AccountDatabaseProvider>()));
  locator.registerLazySingleton<SearchNetworkProvider>(
      () => SearchNetworkProvider());
  locator.registerLazySingleton<SearchDatabaseProvider>(
      () => SearchDatabaseProvider(database.secureStorage));
  locator.registerLazySingleton<SearchRepository>(() => SearchRepository(
        apiService: locator.get<SearchNetworkProvider>(),
        searchDatabaseService: locator.get<SearchDatabaseProvider>(),
      ));
  locator.registerLazySingleton<CategoryNetworkProvider>(
      () => CategoryNetworkProvider());
  locator.registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(locator.get<CategoryNetworkProvider>()));
//   locator.registerLazySingleton<CartNetworkProvider>(() => CartNetworkProvider());
//   locator.registerLazySingleton<CartDatabaseProvider>(() => CartDatabaseProvider(database.secureStorage));
//   locator.registerLazySingleton<CartRepository>(() => CartRepository());
  locator.registerLazySingleton<AddressNetworkProvider>(
      () => AddressNetworkProvider());
  locator.registerLazySingleton<AddressRepository>(() => AddressRepository(
        apiService: locator.get<AddressNetworkProvider>(),
        accountDatabaseService: locator.get<AccountDatabaseProvider>(),
      ));
  locator.registerLazySingleton<LocationService>(() => LocationService());
  locator.registerLazySingleton<LocationApiService>(() => LocationApiService());
  locator.registerLazySingleton<LocationRepository>(() => LocationRepository(
        apiService: locator.get<LocationApiService>(),
        locationService: locator.get<LocationService>(),
      ));

//   locator.registerLazySingleton<WishlistNetworkProvider>(() => WishlistNetworkProvider());
//   locator.registerLazySingleton<WishlistRepository>(() => WishlistRepository());
  locator
      .registerLazySingleton<HomeNetworkProvider>(() => HomeNetworkProvider());
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository(
        locator.get<HomeNetworkProvider>(),
      ));
}
