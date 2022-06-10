abstract class IBalanceController{

  Future<bool> isEnoughAsync(double requestedAmount);

  Future<double> getBalanceAsync();

  Future<void> spendBalanceAsync(double amount);

  Future<void> addBalanceAsync(double amount);
}