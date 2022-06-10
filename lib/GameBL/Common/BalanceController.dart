import 'dart:async';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/di.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: IBalanceController)
class BalanceController extends IBalanceController{
  final String key = "balance";

  Future<bool> isEnoughAsync(double requestedAmount) async {
      var balance = await getBalanceAsync();

      return balance - requestedAmount >= 0;
  }

  Future<double> getBalanceAsync() async {
    final localStorage = await getIt.getAsync<SharedPreferences>();
    if (!localStorage.containsKey(key)){
      localStorage.setDouble(key, 0);
    }

    return localStorage.getDouble(key)!;
  }

  Future<void> spendBalanceAsync(double amount) async{
    var balance = await getBalanceAsync();

    var newBalance = balance - amount;

    if (newBalance < 0)
      throw Exception("Not enough money on balance");

  }

  @override
  Future<void> addBalanceAsync(double amount) async {
      var currentBalance = await getBalanceAsync();
      var newBalance = currentBalance + amount;
      final localStorage = await getIt.getAsync<SharedPreferences>();
      localStorage.setDouble(key, newBalance);
  }
}