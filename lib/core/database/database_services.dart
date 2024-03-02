import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/models/transaction.dart';

class DatabaseServices {
  final _verBox = Hive.box(DatabaseConstants.verBox);
  final _transactionsBox = Hive.box(DatabaseConstants.transactionsBox);

  final List<Transaction> initialData = [
    Transaction(
      title: 'Groceries',
      amount: 175.00,
      date: DateTime.now().toUtc(),
      category:
          Category(name: 'Groceries', colorCode: const Color(0xFFE1E6C3).value),
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Salary',
      amount: 1000.00,
      date: DateTime.now().subtract(const Duration(days: 5)).toUtc(),
      category:
          Category(name: 'Salary', colorCode: const Color(0xFFC3E6C8).value),
      transactionType: TransactionType.income,
    ),
    Transaction(
      title: 'Shopping',
      amount: 100.00,
      date: DateTime.now().subtract(const Duration(days: 12)).toUtc(),
      category:
          Category(name: 'Shopping', colorCode: const Color(0xFFC3C7E6).value),
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Flat Renting',
      amount: 400.00,
      date: DateTime.now().subtract(const Duration(days: 17)).toUtc(),
      category:
          Category(name: 'Renting', colorCode: const Color(0xFFDFC3E6).value),
      transactionType: TransactionType.income,
    ),
  ];

  // Verification Database
  bool isVerificationDatabaseInitialized() {
    return _verBox.get(DatabaseConstants.verBox) != null;
  }

  void initializeVerificationDatabaseAndStoreUserPinCode(String pin) {
    _verBox.put(DatabaseConstants.verBox, pin);
  }

  bool isVerifiedUserPinCode(String pinCode) {
    final storedPinCode = _verBox.get(DatabaseConstants.verBox);
    return storedPinCode == pinCode;
  }

  // Transactions Database
  bool isTransactionsDatabaseInitialized() {
    return _transactionsBox.get(DatabaseConstants.transactionsBox) != null;
  }

  List<Transaction> getTransactionsFromDatabase() {
    if (isTransactionsDatabaseInitialized()) {
      _initializeTransactionsDatabase();
    }

    List<Transaction> transactions =
        _transactionsBox.values.cast<Transaction>().toList();
    return transactions;
  }

  void _initializeTransactionsDatabase() {
    for (var transaction in initialData) {
      _transactionsBox.put(transaction.createdAt, transaction);
    }
  }

  void saveTransactionToDatabase(Transaction newTransaction) {
    _transactionsBox.put(newTransaction.createdAt, newTransaction);
  }

  void deleteTransactionFromDatabase(String transactionId) {
    _transactionsBox.delete(transactionId);
  }
}
