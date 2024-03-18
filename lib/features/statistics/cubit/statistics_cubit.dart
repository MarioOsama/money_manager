import 'package:bloc/bloc.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/statistics/data/repos/statistics_repo.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final StatisticsRepo _statisticsRepo;
  StatisticsCubit(this._statisticsRepo) : super(const StatisticsInitial());

  void loadStatistics(TransactionType transactionsType) {
    emit(const StatisticsLoading());
    try {
      final transactions =
          _statisticsRepo.getTransactionsByType(transactionsType);
      final totalIncome = _statisticsRepo.totalIncome;
      final totalExpense = _statisticsRepo.totalExpense;
      final balance = totalIncome - totalExpense;
      final categoriesTransactionsMap =
          _statisticsRepo.filterTransactionsByCategory(transactions);
      final categoriesPercentage =
          _statisticsRepo.calculateCategoriesPercentage(
              categoriesTransactionsMap,
              transactionsType == TransactionType.expense);
      final amountOverTime = getLineChartData(transactions, 31);

      emit(StatisticsLoaded(
        isExpense: transactionsType == TransactionType.expense,
        transactions: transactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
        balance: balance,
        categoriesTransactionsMap: categoriesTransactionsMap,
        pieChartData: categoriesPercentage,
        lineChartData: amountOverTime,
      ));
    } catch (e) {
      emit(StatisticsError(e.toString()));
    }
  }

  List<double> getLineChartData(List<Transaction> transactions, int period) {
    return _statisticsRepo.calculateAmountOverTime(transactions, period);
  }
}
