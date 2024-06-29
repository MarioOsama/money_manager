import 'package:bloc/bloc.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/all_transactions/data/repos/all_transaction_repo.dart';

part 'all_transactions_state.dart';

class AllTransactionsCubit extends Cubit<AllTransactionsState> {
  final AllTransactionsRepo _allTransactionsRepo;
  AllTransactionsCubit(this._allTransactionsRepo)
      : super(const AllTransactionsInitialState());

  List<Transaction> transactionsList = [];

  void loadAllTransactions(TransactionType transactionType) {
    emit(const AllTransactionsLoadingState());
    transactionsList = _getAllTypeTransactionsList(transactionType);
    emit(AllTransactionsLoadedState(transactionsList));
  }

  List<Transaction> _getAllTypeTransactionsList(
          TransactionType transactionType) =>
      _allTransactionsRepo.getFilteredTransactions(transactionType);

  Category getTransactionCategory(String categoryName) {
    return _allTransactionsRepo.getTransactionCategory(categoryName);
  }

  String get getCurrencyAbbreviation =>
      _allTransactionsRepo.getCurrencyAbbreviation();

  String get getDateFormat => _allTransactionsRepo.getDateFormat();

  void sortTransactions(String sortingType) {
    switch (sortingType) {
      case 'Lowest Price':
        lowestSorting();
      case 'Highest Price':
        highestSorting();
      case 'Newest Date':
        newestSorting();
      case 'Oldest Date':
        oldestSorting();
    }
  }

  void lowestSorting() {
    transactionsList.sort((a, b) => a.amount.compareTo(b.amount));
    emit(AllTransactionsLoadedState(transactionsList));
  }

  void highestSorting() {
    transactionsList.sort((a, b) => b.amount.compareTo(a.amount));
    emit(AllTransactionsLoadedState(transactionsList));
  }

  void newestSorting() {
    transactionsList.sort((a, b) => b.date.compareTo(a.date));
    emit(AllTransactionsLoadedState(transactionsList));
  }

  void oldestSorting() {
    transactionsList.sort((a, b) => a.date.compareTo(b.date));
    emit(AllTransactionsLoadedState(transactionsList));
  }
}
