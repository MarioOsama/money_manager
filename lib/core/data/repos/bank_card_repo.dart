import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class BankCardRepo {
  final DatabaseServices _databaseServices;
  List<Transaction> allTransactions = [];
  List<Transaction> expenses = [];
  List<Transaction> incomes = [];

  BankCardRepo(this._databaseServices);

  List<Transaction> loadTransactionsFromDatabase() {
    allTransactions = _databaseServices.getTransactionsFromDatabase();
    return allTransactions;
  }

  (List<Transaction>, List<Transaction>) filteTransactionsByType() {
    expenses = allTransactions
        .where((transaction) =>
            transaction.transactionType == TransactionType.expense)
        .toList();
    incomes = allTransactions
        .where((transaction) =>
            transaction.transactionType == TransactionType.income)
        .toList();

    return (expenses, incomes);
  }

  double getExpensesAmount() {
    double expensesAmount = 0;
    for (var transaction in expenses) {
      expensesAmount += transaction.amount;
    }
    return expensesAmount;
  }

  double getIncomesAmount() {
    double incomesAmount = 0;
    for (var transaction in incomes) {
      incomesAmount += transaction.amount;
    }
    return incomesAmount;
  }
}
