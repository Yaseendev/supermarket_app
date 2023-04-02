import 'package:dartz/dartz.dart';
import 'package:supermarket_app/Account/data/providers/account_db_provider.dart';
import 'package:supermarket_app/Shared/models/network_failure.dart';
import '../models/user.dart';
import '../providers/account_network_provider.dart';

class AccountRepository {
  late final AccountNetworkProvider _apiService;
  late final AccountDatabaseProvider _databaseService;

  AccountRepository(AccountNetworkProvider apiService,
      AccountDatabaseProvider databaseService) {
    this._apiService = apiService;
    //locator.get<AccountNetworkProvider>();
    this._databaseService = databaseService;
    // locator.get<AccountDatabaseProvider>();
  }

  Future<Either<Failure, User>> signupUser(User user, String password) async {
    try {
      final result = await _apiService.signup(user, password);
      await _databaseService.setToken(result['data']['token']);
      final appUser = User.fromMap(result['data']);
      await _databaseService.setUser(appUser);
      return Right(appUser);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, User>> signinUser(
      String email, String password) async {
    try {
      final result = await _apiService.signin(email, password);
      await _databaseService.setToken(result['data']['token']);
      final appUser = User.fromMap(result['data']);
      await _databaseService.setUser(appUser);
      return Right(appUser);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, dynamic>> resetPassword(String email) async {
    try {
      final result = await _apiService.resetPassword(email);
      return Right(result);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
