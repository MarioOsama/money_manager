import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class CategoriesRepo {
  final DatabaseServices _databaseServices;
  List<Category> allCategories = [];
  List<Transaction> _allTransactions = [];

  Map<String, int> categoriesColors = {
    'Rose': 0xFFE6C3C3,
    'Sunshine': 0xFFE6E0C3,
    'Mint': 0xFFC3E6C3,
    'Sky': 0xFFC3E2E6,
    'Ocean': 0xFFC3D6E6,
    'Lavender': 0xFFD9C3E6,
    'Grape': 0xFFCFC3E6,
    'Pink': 0xFFE6C3DC,
  };

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

  void saveNewCategory(Category newCategory) {
    final isCategoryExist = _databaseServices.isCategoryExist(newCategory.name);
    if (!isCategoryExist) {
      _databaseServices.saveNewCategoryToDatabase(newCategory);
    }
  }

  void deleteCategoryAndItsTransactionFromDatabase(String categoryName) {
    final List<Transaction> transactionsList =
        _databaseServices.getTransactionsFromDatabase();
    final List<Transaction> transactionsListToDelete = transactionsList
        .where((transaction) => transaction.categoryName == categoryName)
        .toList();
    transactionsListToDelete.forEach((transaction) {
      _databaseServices.deleteTransactionFromDatabase(transaction.createdAt);
    });
    _databaseServices.deleteCategoryFromDatabase(categoryName);
  }

  isCategoryExists(String categoryName) {
    final isCategoryExists = _databaseServices.isCategoryExist(categoryName);
    return isCategoryExists;
  }
}
