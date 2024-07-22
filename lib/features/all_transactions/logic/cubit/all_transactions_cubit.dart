import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/all_transactions/data/repos/all_transaction_repo.dart';

part 'all_transactions_state.dart';

class AllTransactionsCubit extends Cubit<AllTransactionsState> {
  final AllTransactionsRepo _allTransactionsRepo;
  AllTransactionsCubit(this._allTransactionsRepo)
      : super(const AllTransactionsInitialState());

  // Controller
  PageController pageController = PageController();

  // Data
  List<DateTime> pageDates = [];
  List<Transaction> allTransactionsList = [];
  Map<String, List<Transaction>> transactionsByMonthMap = {};
  int currentFilteredListIndex = 0;

  void loadAllTransactions(TransactionType transactionType) {
    emit(const AllTransactionsLoadingState());
    allTransactionsList = _getAllTypeTransactionsList(transactionType);
    if (allTransactionsList.isEmpty) {
      emit(const AllTransactionsEmptyState());
      return;
    }
    // Split transactions into months
    splitIntoMonths();
    // Setup page controller
    setupPageController();
    // Setup page dates
    setupPageDates();
    emit(AllTransactionsLoadedState(allTransactionsList));
  }

  /// Get all transactions list by [transactionType] if it's [TransactionType.expense] or [TransactionType.income]
  List<Transaction> _getAllTypeTransactionsList(
          TransactionType transactionType) =>
      _allTransactionsRepo.getFilteredTransactions(transactionType);

  Category getTransactionCategory(String categoryName) {
    return _allTransactionsRepo.getTransactionCategory(categoryName);
  }

  String get getCurrencyAbbreviation =>
      _allTransactionsRepo.getCurrencyAbbreviation();

  String get getDateFormat => _allTransactionsRepo.getDateFormat();

  /// Call the specific [sortingType] sorting function then emit loaded state to update the list ordering in UI
  void sortTransactions(String sortingType) {
    try {
      setupCurrentIndex();
    } catch (e) {
      log(e.toString());
    }
    switch (sortingType) {
      case 'Lowest Price':
        lowestSorting();
      case 'Highest Price':
        highestSorting();
      case 'Newest Date':
        newestSorting();
      case 'Oldest Date':
        oldestSorting();
      case 'By Category':
        categorySorting();
    }
    emit(AllTransactionsLoadedState(
        transactionsByMonthMap.values.elementAt(currentFilteredListIndex)));
  }

  /// Split the transactions list into months to be able to filter them by month
  void splitIntoMonths() {
    // Sort transactions by date to prevent any issues in splitting
    allTransactionsList.sort((a, b) {
      return b.date.compareTo(a.date);
    });
    final List<Transaction> transactions = allTransactionsList;
    final List<Transaction> currentMonthTransactions = [];
    int currentMonth = transactions.first.date.month;
    int currentYear = transactions.first.date.year;
    for (final Transaction transaction in transactions) {
      // Check if the current transaction is in the same month and year
      if (currentMonth == transaction.date.month &&
          currentYear == transaction.date.year) {
        currentMonthTransactions.add(transaction);
      } else {
        // Add the current month transactions to the map then clear the list and update the month and year
        transactionsByMonthMap['$currentMonth-$currentYear'] = [
          ...currentMonthTransactions
        ];
        currentMonthTransactions.clear();
        currentMonthTransactions.add(transaction);
        currentMonth = transaction.date.month;
        currentYear = transaction.date.year;
      }
    }
    transactionsByMonthMap['$currentMonth-$currentYear'] = [
      ...currentMonthTransactions
    ];
  }

  /// Sorting the transactions list by price with ascending ordering
  void lowestSorting() {
    transactionsByMonthMap.values
        .elementAt(currentFilteredListIndex)
        .sort((a, b) => a.amount.compareTo(b.amount));
  }

  /// Sorting the transactions list by price with descending ordering
  void highestSorting() {
    transactionsByMonthMap.values
        .elementAt(currentFilteredListIndex)
        .sort((a, b) => b.amount.compareTo(a.amount));
  }

  /// Sorting the transactions list by date with descending ordering
  void newestSorting() {
    transactionsByMonthMap.values
        .elementAt(currentFilteredListIndex)
        .sort((a, b) => b.date.compareTo(a.date));
  }

  /// Sorting the transactions list by date with ascending ordering
  void oldestSorting() {
    transactionsByMonthMap.values
        .elementAt(currentFilteredListIndex)
        .sort((a, b) => a.date.compareTo(b.date));
  }

  /// Sorting the transactions list by the highst amount category
  void categorySorting() {
    transactionsByMonthMap.values
        .elementAt(currentFilteredListIndex)
        .sort((a, b) {
      final double firstCategoryTotalAmount =
          _allTransactionsRepo.getCategoryByName(a.categoryName).totalAmount;
      final double secondCategoryTotalAmount =
          _allTransactionsRepo.getCategoryByName(b.categoryName).totalAmount;
      return secondCategoryTotalAmount.compareTo(firstCategoryTotalAmount);
    });
  }

  /// Get the oldest transaction date from the transactions list
  DateTime getOldestTransactionDate() {
    allTransactionsList.sort((a, b) => a.date.compareTo(b.date));
    return allTransactionsList.first.date;
  }

  /// Get the newest transaction date from the transactions list
  DateTime getNewestTransactionDate() {
    allTransactionsList.sort((a, b) => b.date.compareTo(a.date));
    return allTransactionsList.first.date;
  }

  // Helper functions
  void setupPageController() {
    pageController = PageController(
      initialPage: transactionsByMonthMap.keys.length - 1,
    );
  }

  void setupCurrentIndex() {
    currentFilteredListIndex =
        transactionsByMonthMap.keys.length - 1 - pageController.page!.toInt();
  }

  void setupPageDates() {
    pageDates = transactionsByMonthMap.keys
        .toList()
        .reversed
        .map((strDate) => DateTime(int.parse(strDate.split('-').last),
            int.parse(strDate.split('-').first)))
        .toList();
  }
}
