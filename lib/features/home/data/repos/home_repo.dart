import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class HomeRepo {
  final DatabaseServices _databaseServices;
  List<Transaction> allTransactions = [];
  List<Transaction> expenses = [];
  List<Transaction> incomes = [];

  HomeRepo(this._databaseServices);

  List<Transaction> getTransactionsFromDatabase() {
    allTransactions = _databaseServices.getTransactionsFromDatabase();
    return allTransactions;
  }

  (List<Transaction>, List<Transaction>) getFilteredTransactionsByType() {
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

  // List<Transaction> getTransactionsByCategory(String category) {
  //   final List<Transaction> transactions = allTransactions
  //       .where((transaction) => transaction.category == category)
  //       .toList();
  //   return transactions;
  // }
}
