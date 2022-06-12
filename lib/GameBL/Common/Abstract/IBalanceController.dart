import 'package:event/event.dart';

abstract class IBalanceController{

  Event<Value<int>> balanceUpdatedEvent = Event<Value<int>>();

  Future<bool> isEnoughAsync(int requestedAmount);

  Future<int> getBalanceAsync();

  Future<void> spendBalanceAsync(int amount);

  Future<void> addBalanceAsync(int amount);
}