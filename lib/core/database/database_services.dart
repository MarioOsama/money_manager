import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/models/transaction.dart';

class DatabaseServices {
  final _verBox = Hive.box(DatabaseConstants.verBox);
  final _transactionsBox = Hive.box(DatabaseConstants.transactionsBox);
  final _categoriesBox = Hive.box(DatabaseConstants.categoriesBox);

  final List<Transaction> initialTransactions = [
    Transaction(
      title: 'Groceries',
      amount: 175.00,
      date: DateTime.now().toUtc(),
      categoryName: 'Super Market',
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Salary',
      amount: 1000.00,
      date: DateTime.now().subtract(const Duration(days: 5)).toUtc(),
      categoryName: 'Salary',
      transactionType: TransactionType.income,
    ),
    Transaction(
      title: 'Shoes',
      amount: 100.00,
      date: DateTime.now().subtract(const Duration(days: 12)).toUtc(),
      categoryName: 'Shopping',
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Flat Renting',
      amount: 400.00,
      date: DateTime.now().subtract(const Duration(days: 17)).toUtc(),
      categoryName: 'Renting',
      transactionType: TransactionType.income,
    ),
  ];

  final List<Category> initialCategories = [
    Category(
      name: 'Super Market',
      colorCode: const Color(0xFFE1E6C3).value,
    ),
    Category(
      name: 'Salary',
      colorCode: const Color(0xFFC3E6C8).value,
    ),
    Category(
      name: 'Shopping',
      colorCode: const Color(0xFFC3C7E6).value,
    ),
    Category(
      name: 'Renting',
      colorCode: const Color(0xFFDFC3E6).value,
    ),
  ];

  // Verification Database
  bool isVerificationDatabaseInitialized() {
    return _verBox.get(DatabaseConstants.verBox) != null;
  }

  void initializUserAndData(String pin) {
    _verBox.put(DatabaseConstants.verBox, pin);
    _initializeTransactionsDatabase();
    _initializeCategoriesDatabase();
  }

  bool isVerifiedUserPinCode(String pinCode) {
    final storedPinCode = _verBox.get(DatabaseConstants.verBox);
    return storedPinCode == pinCode;
  }

  // Transactions Database
  void _initializeTransactionsDatabase() {
    for (var transaction in initialTransactions) {
      _transactionsBox.put(transaction.createdAt, transaction);
    }
  }

  List<Transaction> getTransactionsFromDatabase() {
    List<Transaction> transactions =
        _transactionsBox.values.cast<Transaction>().toList();
    return transactions;
  }

  void saveTransactionToDatabase(Transaction newTransaction) {
    _transactionsBox.put(newTransaction.createdAt, newTransaction);
  }

  void deleteTransactionFromDatabase(String transactionId) {
    _transactionsBox.delete(transactionId);
  }

  // Categories Database
  void _initializeCategoriesDatabase() {
    for (var category in initialCategories) {
      _categoriesBox.put(category.name, category);
    }
  }

  List<Category> getCategoriesFromDatabase() {
    List<Category> categories = _categoriesBox.values.cast<Category>().toList();
    return categories;
  }

  Category getCategoryByName(String categoryName) {
    return _categoriesBox.get(categoryName);
  }
}
