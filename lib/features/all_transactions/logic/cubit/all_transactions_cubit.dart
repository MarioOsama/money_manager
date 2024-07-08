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

  /// Call the specific [sortingType] sorting function then emit loaded state to update the list ordering in UI
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
      case 'By Category':
        categorySorting();
    }
    emit(AllTransactionsLoadedState(transactionsList));
  }

  /// Sorting the transactions list by price with ascending ordering
  void lowestSorting() {
    transactionsList.sort((a, b) => a.amount.compareTo(b.amount));
  }

  /// Sorting the transactions list by price with descending ordering
  void highestSorting() {
    transactionsList.sort((a, b) => b.amount.compareTo(a.amount));
  }

  /// Sorting the transactions list by date with descending ordering
  void newestSorting() {
    transactionsList.sort((a, b) => b.date.compareTo(a.date));
  }

  /// Sorting the transactions list by date with ascending ordering
  void oldestSorting() {
    transactionsList.sort((a, b) => a.date.compareTo(b.date));
  }

  /// Sorting the transactions list by the highst amount category
  void categorySorting() {
    transactionsList.sort((a, b) {
      final double firstCategoryTotalAmount =
          _allTransactionsRepo.getCategoryByName(a.categoryName).totalAmount;
      final double secondCategoryTotalAmount =
          _allTransactionsRepo.getCategoryByName(b.categoryName).totalAmount;
      return secondCategoryTotalAmount.compareTo(firstCategoryTotalAmount);
    });
  }
}
