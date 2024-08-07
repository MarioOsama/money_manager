import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/models/transaction.dart';

class DatabaseServices {
  final _userBox = Hive.box(DatabaseConstants.userBox);
  final _transactionsBox = Hive.box(DatabaseConstants.transactionsBox);
  final _categoriesBox = Hive.box(DatabaseConstants.categoriesBox);

  final List<Transaction> initialTransactions = [
    Transaction(
      title: 'Groceries',
      amount: 175.00,
      date: DateTime.now().toLocal(),
      categoryName: 'Super Market',
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Salary',
      amount: 1000.00,
      date: DateTime.now().subtract(const Duration(days: 5)).toLocal(),
      categoryName: 'Salary',
      transactionType: TransactionType.income,
    ),
    Transaction(
      title: 'Shoes',
      amount: 100.00,
      date: DateTime.now().subtract(const Duration(days: 12)).toLocal(),
      categoryName: 'Shopping',
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Flat Renting',
      amount: 400.00,
      date: DateTime.now().subtract(const Duration(days: 17)).toLocal(),
      categoryName: 'Renting',
      transactionType: TransactionType.income,
    ),
  ];

  final List<Category> initialCategories = [
    Category(
      name: 'Super Market',
      colorCode: const Color(0xFFE1E6C3).value,
      totalAmount: 175.00,
    ),
    Category(
      name: 'Salary',
      colorCode: const Color(0xFFC3E6C8).value,
      totalAmount: 1000.00,
    ),
    Category(
      name: 'Shopping',
      colorCode: const Color(0xFFC3C7E6).value,
      totalAmount: 100.00,
    ),
    Category(
      name: 'Renting',
      colorCode: const Color(0xFFDFC3E6).value,
      totalAmount: 400.00,
    ),
    Category(
      name: 'Others',
      colorCode: const Color(0xFFECD1D1).value,
      totalAmount: 0.0,
    ),
  ];

  // User Database
  bool isVerificationDatabaseInitialized() {
    return _userBox.get(DatabaseConstants.userBox) != null;
  }

  void initializUserAndData(String pin) {
    // Save user pin code
    _userBox.put(DatabaseConstants.userBox, pin);
    // Initialize user preferences
    _initializeUserPreferences();
    // Initialize transactions and categories database
    _initializeTransactionsDatabase();
    _initializeCategoriesDatabase();
  }

  void _initializeUserPreferences() {
    _userBox.put(DatabaseConstants.currency, '\$');
    _userBox.put(DatabaseConstants.dateFormat, 'DD/MM/YYYY');
    _userBox.put(DatabaseConstants.language, 'English');
  }

  Map<String, dynamic> getUserPreferences() {
    final currency = _userBox.get(DatabaseConstants.currency);
    final dateFormat = _userBox.get(DatabaseConstants.dateFormat);
    final language = _userBox.get(DatabaseConstants.language);
    return {
      DatabaseConstants.currency: currency,
      DatabaseConstants.dateFormat: dateFormat,
      DatabaseConstants.language: language,
    };
  }

  String getLanguageCode() {
    final String? language = _userBox.get(DatabaseConstants.language);
    if (language == 'العربية') {
      return 'ar';
    } else {
      return 'en';
    }
  }

  bool isVerifiedUserPinCode(String pinCode) {
    final storedPinCode = _userBox.get(DatabaseConstants.userBox);
    return storedPinCode == pinCode;
  }

  void saveUserPreferences(Map<String, dynamic> newPreferences) {
    newPreferences.forEach((key, preference) {
      log(preference.toString());
      _userBox.put(key, preference);
    });
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
    updateCategoryAmount(newTransaction.categoryName);
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
    categoryName = categoryName.replaceAll('(', '');
    categoryName = categoryName.replaceAll(')', '');
    return _categoriesBox.get(categoryName);
  }

  bool isCategoryExist(String categoryName) {
    final isExist = _categoriesBox.get(categoryName);
    if (isExist == null) {
      return false;
    }
    return true;
  }

  void saveNewCategoryToDatabase(Category newCategory) {
    _categoriesBox.put(newCategory.name, newCategory);
  }

  void updateCategoryAmount(String categoryName) {
    final transactionCategory = getCategoryByName(categoryName);
    saveNewCategoryToDatabase(transactionCategory);
  }

  void deleteCategoryFromDatabase(String categoryName) {
    _categoriesBox.delete(categoryName);
  }

  // Resetting Password
  bool checkCurrentPassword(String password) {
    final userPin = _userBox.get(DatabaseConstants.userBox);
    return userPin == password;
  }

  void resetPassword(String password) {
    _userBox.put(DatabaseConstants.userBox, password);
  }
}
