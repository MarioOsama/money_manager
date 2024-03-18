import 'package:bloc/bloc.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/all_transactions/data/repos/all_transaction_repo.dart';

part 'all_transactions_state.dart';

class AllTransactionsCubit extends Cubit<AllTransactionsState> {
  final AllTransactionsRepo _allTransactionsRepo;
  AllTransactionsCubit(this._allTransactionsRepo)
      : super(const AllTransactionsInitialState());

  void loadAllTransactions(TransactionType transactionType) {
    emit(AllTransactionsLoadingState(transactionType));
    final List<Transaction> allTransactions = _getAllTransactionsList;
    emit(AllTransactionsLoadedState(allTransactions));
  }

  List<Transaction> get _getAllTransactionsList =>
      _allTransactionsRepo.getFilteredTransactions(
          (state as AllTransactionsLoadingState).transactionType);

  Category getTransactionCategory(String categoryName) {
    return _allTransactionsRepo.getTransactionCategory(categoryName);
  }

  String get getCurrencyAbbreviation =>
      _allTransactionsRepo.getCurrencyAbbreviation();

  String get getDateFormat => _allTransactionsRepo.getDateFormat();
}
