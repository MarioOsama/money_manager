part of 'transaction_cubit.dart';

@immutable
abstract class TransactionState {
  const TransactionState();

  // get getValue => null;
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoaded({required this.transactions});
}

class TransactionFiltered extends TransactionState {
  final List<Transaction> expenses;
  final List<Transaction> incomes;
  final double expensesAmount;
  final double incomesAmount;

  const TransactionFiltered(
      {required this.expensesAmount,
      required this.incomesAmount,
      required this.expenses,
      required this.incomes});
}

class TransactionCreate extends TransactionState {
  final Transaction transaction;

  const TransactionCreate({required this.transaction});
}

class TransactionUpdate extends TransactionState {
  final Transaction transaction;

  const TransactionUpdate({required this.transaction});
}

class TransactionDelete extends TransactionState {
  final Transaction transaction;

  const TransactionDelete({required this.transaction});
}

class TransactionSuccess extends TransactionState {
  final String message;

  const TransactionSuccess({required this.message});
}

class TransactionErrorState extends TransactionState {
  final String error;
  final int errorCode;

  const TransactionErrorState({required this.error, required this.errorCode});

  // @override
  // String get getValue => error;

  // int get getErrorCode => errorCode;
}
