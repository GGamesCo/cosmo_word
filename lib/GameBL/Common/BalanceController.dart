import 'dart:async';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/di.dart';
import 'package:event/event.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: IBalanceController)
class BalanceController extends IBalanceController{
  final int defaultValue = 500;
  final String key = "balance";

  Future<bool> isEnoughAsync(int requestedAmount) async {
      var balance = await getBalanceAsync();

      return balance - requestedAmount >= 0;
  }

  Future<int> getBalanceAsync() async {
    final localStorage = await getIt.getAsync<SharedPreferences>();
    if (!localStorage.containsKey(key)){
      localStorage.setInt(key, defaultValue);
    }

    return localStorage.getInt(key)!;
  }

  Future<void> spendBalanceAsync(int amount) async{
    var balance = await getBalanceAsync();

    var newBalance = balance - amount;

    if (newBalance < 0)
      throw Exception("Not enough money on balance");

    balanceUpdatedEvent.broadcast(Value<int>(newBalance));
  }

  @override
  Future<void> addBalanceAsync(int amount) async {
     print("Add \(amount) coins to user balance.");
      var currentBalance = await getBalanceAsync();
      var newBalance = currentBalance + amount;
      final localStorage = await getIt.getAsync<SharedPreferences>();
      localStorage.setInt(key, newBalance);

     balanceUpdatedEvent.broadcast(Value<int>(newBalance));
  }
}