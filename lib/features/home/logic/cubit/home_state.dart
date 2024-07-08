part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Transaction> transactions;

  const HomeLoaded({required this.transactions});
}

class HomeTransactionsFiltered extends HomeState {
  final List<Transaction> expenses;
  final List<Transaction> incomes;
  final double expensesAmount;
  final double incomesAmount;

  const HomeTransactionsFiltered(
      {required this.expensesAmount,
      required this.incomesAmount,
      required this.expenses,
      required this.incomes});

  HomeTransactionsFiltered copyWith({
    double? expensesAmount,
    double? incomesAmount,
    List<Transaction>? expenses,
    List<Transaction>? incomes,
  }) {
    return HomeTransactionsFiltered(
      expensesAmount: expensesAmount ?? this.expensesAmount,
      incomesAmount: incomesAmount ?? this.incomesAmount,
      expenses: expenses ?? this.expenses,
      incomes: incomes ?? this.incomes,
    );
  }

  double get getTotalBalance => incomesAmount - expensesAmount;
}

class HomeError extends HomeState {
  final String error;
  final int errorCode;

  const HomeError({required this.error, required this.errorCode});
}
