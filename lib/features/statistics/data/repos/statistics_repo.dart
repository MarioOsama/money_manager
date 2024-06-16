import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class StatisticsRepo {
  final DatabaseServices _databaseServices;

  StatisticsRepo(this._databaseServices);

  List<Transaction> getTransactionsByType(TransactionType transactionType) {
    final transactions = _databaseServices.getTransactionsFromDatabase();
    return transactions
        .where((transaction) => transaction.transactionType == transactionType)
        .toList();
  }

  Map<Category, List<Transaction>> filterTransactionsByCategory(
      List<Transaction> transactions) {
    final categories = _databaseServices.getCategoriesFromDatabase();

    final transactionsByCategory = <Category, List<Transaction>>{};

    for (final category in categories) {
      final categoryTransactions = transactions
          .where((transaction) => transaction.categoryName == category.name)
          .toList();

      if (categoryTransactions.isNotEmpty) {
        transactionsByCategory[category] = categoryTransactions;
      }
    }

    return transactionsByCategory;
  }

  double get totalIncome {
    final transactions = _databaseServices.getTransactionsFromDatabase();
    final incomeTransactions = transactions
        .where((transaction) =>
            transaction.transactionType == TransactionType.income)
        .toList();

    return incomeTransactions.fold<double>(
        0, (previousValue, transaction) => previousValue + transaction.amount);
  }

  double get totalExpense {
    final transactions = _databaseServices.getTransactionsFromDatabase();
    final expenseTransactions = transactions
        .where((transaction) =>
            transaction.transactionType == TransactionType.expense)
        .toList();

    return expenseTransactions.fold<double>(
        0, (previousValue, transaction) => previousValue + transaction.amount);
  }

  Map<Category, double> calculateCategoriesPercentage(
      Map<Category, List<Transaction>> transactionsMap, bool isExpense) {
    final totalAmount = isExpense ? totalExpense : totalIncome;
    final categoriesPercentage = <Category, double>{};

    transactionsMap.forEach((category, transactions) {
      final categoryTotal = transactions.fold<double>(0,
          (previousValue, transaction) => previousValue + transaction.amount);

      final percentage = (categoryTotal / totalAmount) * 100;
      categoriesPercentage[category] = percentage;
    });

    return categoriesPercentage;
  }

  List<double> calculateAmountOverTime(
      List<Transaction> transactions, int dateDifference) {
    final amountOverTime = <double>[];

    for (var i = 0; i < dateDifference; i++) {
      final currentDate = DateTime.now().subtract(Duration(days: i));
      final currentDayTransactions = transactions
          .where((transaction) =>
              transaction.date.day == currentDate.day &&
              transaction.date.month == currentDate.month &&
              transaction.date.year == currentDate.year)
          .toList();

      final currentDayAmount = currentDayTransactions.fold<double>(0,
          (previousValue, transaction) => previousValue + transaction.amount);

      amountOverTime.add(currentDayAmount);
    }

    return amountOverTime;
  }

  Map<String, List<Transaction>> getTransactionsByDate(
      List<Transaction> transactions) {
    final List<Transaction> todayTransactions = [];
    final List<Transaction> weekTransactions = [];
    final List<Transaction> monthTransations = [];

    for (var transaction in transactions) {
      if (transaction.date.difference(DateTime.now()).inDays == 0) {
        todayTransactions.add(transaction);
      }
      if (transaction.date.difference(DateTime.now()).inDays.abs() <= 7) {
        weekTransactions.add(transaction);
      }
      if (transaction.date.difference(DateTime.now()).inDays.abs() <= 30) {
        monthTransations.add(transaction);
      }
    }

    return {
      'today': todayTransactions,
      'week': weekTransactions,
      'month': monthTransations,
    };
  }
}
