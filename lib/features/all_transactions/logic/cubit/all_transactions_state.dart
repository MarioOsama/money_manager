part of 'all_transactions_cubit.dart';

abstract class AllTransactionsState {
  const AllTransactionsState();
}

class AllTransactionsInitialState extends AllTransactionsState {
  const AllTransactionsInitialState();
}

class AllTransactionsLoadingState extends AllTransactionsState {
  const AllTransactionsLoadingState();
}

class AllTransactionsLoadedState extends AllTransactionsState {
  final List<Transaction> allTransactions;
  const AllTransactionsLoadedState(this.allTransactions);
}

class AllTransactionsEmptyState extends AllTransactionsState {
  const AllTransactionsEmptyState();
}

class AllTransactionsErrorState extends AllTransactionsState {
  final String error;
  const AllTransactionsErrorState(this.error);
}
