import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/features/home/data/models/transaction.dart';

class DatabaseServices {
  final _verBox = Hive.box(DatabaseConstants.verBox);
  final _transactionsBox = Hive.box(DatabaseConstants.transactionsBox);

  final List<Transaction> initialData = [
    Transaction(
      title: 'Groceries',
      amount: 175.00,
      iconCode: const Icon(Icons.shopping_cart).icon!.codePoint,
      date: DateTime.now(),
      category:
          Category(name: 'Groceries', colorCode: const Color(0xff00ff00).value),
      imagePath:
          'https://images.unsplash.com/photo-1590779033100-9f60a05a013d?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Salary',
      amount: 1000.00,
      iconCode: const Icon(Icons.money).icon!.codePoint,
      date: DateTime.now(),
      category:
          Category(name: 'Salary', colorCode: const Color(0xff0000ff).value),
      imagePath:
          'https://images.unsplash.com/photo-1553729459-efe14ef6055d?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      transactionType: TransactionType.income,
    ),
    Transaction(
      title: 'Shopping',
      amount: 100.00,
      iconCode: const Icon(Icons.shopping_cart).icon!.codePoint,
      date: DateTime.now(),
      category:
          Category(name: 'Shopping', colorCode: const Color(0xffff0000).value),
      imagePath:
          'https://images.unsplash.com/photo-1557821552-17105176677c?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      transactionType: TransactionType.expense,
    ),
    Transaction(
      title: 'Flat Rent',
      amount: 400.00,
      iconCode: const Icon(Icons.money).icon!.codePoint,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category:
          Category(name: 'Salary', colorCode: const Color(0xff0000ff).value),
      imagePath:
          'https://images.unsplash.com/photo-1569152811536-fb47aced8409?q=80&w=1738&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      transactionType: TransactionType.income,
    ),
  ];

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

  bool isTransactionsDatabaseInitialized() {
    return _transactionsBox.get(DatabaseConstants.transactionsBox) != null;
  }

  List<Transaction> getTransactionsFromDatabase() {
    if (isTransactionsDatabaseInitialized() || _transactionsBox.isEmpty) {
      _initializeTransactionsDatabase();
    }

    List<Transaction> transactions =
        _transactionsBox.values.cast<Transaction>().toList();
    return transactions;
  }

  void _initializeTransactionsDatabase() {
    for (var transaction in initialData) {
      _transactionsBox.put(transaction.id, transaction);
    }
  }
}
