import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class CategoriesRepo {
  final DatabaseServices _databaseServices;
  List<Category> allCategories = [];
  List<Transaction> _allTransactions = [];

  CategoriesRepo(this._databaseServices);

  List<Category> getCategories() {
    allCategories = _databaseServices.getCategoriesFromDatabase();
    return allCategories;
  }

  void getTransactionsFromDatabase() {
    _allTransactions = _databaseServices.getTransactionsFromDatabase();
  }

  double getCategoryTransactionsAmount(Category category) {
    getTransactionsFromDatabase();
    final filteredTransaction = _allTransactions
        .where((transaction) => transaction.categoryName == category.name)
        .toList();
    double totalCategoryAmount = filteredTransaction.fold(
        0, (previousValue, transaction) => previousValue + transaction.amount);
    return totalCategoryAmount;
  }

  int getCategoryTransactionsCount(Category category) {
    getTransactionsFromDatabase();
    final filteredTransaction = _allTransactions
        .where((transaction) => transaction.categoryName == category.name)
        .toList();
    return filteredTransaction.length;
  }
}
