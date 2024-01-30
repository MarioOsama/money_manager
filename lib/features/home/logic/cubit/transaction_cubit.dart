import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_manager/features/home/data/models/transaction.dart';
import 'package:money_manager/features/home/data/repos/home_repo.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final HomeRepo _homeRepo;

  TransactionCubit(this._homeRepo) : super(TransactionInitial());

  void getTransactionsData() {
    emit(TransactionLoading());
    try {
      final List<Transaction> transactions =
          _homeRepo.getTransactionsFromDatabase();
      emit(TransactionLoaded(transactions: transactions));
    } catch (e) {
      emit(TransactionErrorState(error: e.toString(), errorCode: 500));
    }
  }

  void filterTransactionsByType(TransactionType transactionType) {
    emit(TransactionLoading());
    try {
      final List<Transaction> expenses;
      final List<Transaction> incomes;
      (expenses, incomes) = _homeRepo.getFilteredTransactionsByType();
      emit(TransactionFiltered(
          expenses: expenses,
          incomes: incomes,
          expensesAmount: getExpensesAmount(),
          incomesAmount: getIncomesAmount()));
    } catch (e) {
      emit(TransactionErrorState(error: e.toString(), errorCode: 500));
    }
  }

  double getExpensesAmount() {
    return _homeRepo.getExpensesAmount();
  }

  double getIncomesAmount() {
    return _homeRepo.getIncomesAmount();
  }
}
