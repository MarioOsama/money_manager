part of 'statistics_cubit.dart';

abstract class StatisticsState {
  const StatisticsState();
}

class StatisticsInitial extends StatisticsState {
  const StatisticsInitial();
}

class StatisticsLoading extends StatisticsState {
  const StatisticsLoading();
}

class StatisticsLoaded extends StatisticsState {
  final bool isExpense;
  final List<Transaction> transactions;
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final Map<Category, List<Transaction>> categoriesTransactionsMap;
  final Map<Category, double> pieChartData;
  final List<double> lineChartData;

  const StatisticsLoaded({
    required this.isExpense,
    required this.transactions,
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.categoriesTransactionsMap,
    required this.pieChartData,
    required this.lineChartData,
  });
}

class StatisticsError extends StatisticsState {
  final String message;

  const StatisticsError(this.message);
}
