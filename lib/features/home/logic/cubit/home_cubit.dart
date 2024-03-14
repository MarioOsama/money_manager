import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  TextEditingController tabIndexController = TextEditingController();

  void getTransactionsData() {
    emit(HomeLoading());
    try {
      final List<Transaction> transactions =
          _homeRepo.getTransactionsFromDatabase();
      emit(HomeLoaded(transactions: transactions));
    } catch (e) {
      emit(HomeError(error: e.toString(), errorCode: 500));
    }
  }

  void filterTransactionsByType() {
    print('filterTransactionsByType');
    emit(HomeLoading());
    try {
      final List<Transaction> expenses;
      final List<Transaction> incomes;
      (expenses, incomes) = _homeRepo.getFilteredTransactionsByType();
      emit(HomeTransactionsFiltered(
          expenses: expenses,
          incomes: incomes,
          expensesAmount: getExpensesAmount(),
          incomesAmount: getIncomesAmount()));
    } catch (e) {
      emit(HomeError(error: e.toString(), errorCode: 500));
    }
  }

  double getExpensesAmount() {
    return _homeRepo.getExpensesAmount();
  }

  double getIncomesAmount() {
    return _homeRepo.getIncomesAmount();
  }

  void deleteTransaction(String transactionId) {
    try {
      _homeRepo.deleteTransaction(transactionId);
    } catch (e) {
      emit(HomeError(error: e.toString(), errorCode: 500));
    }
  }

  Category getTransactionCategory(String categoryName) {
    return _homeRepo.getTransactionCategory(categoryName);
  }

  String get getCurrencyAbbreviation => _homeRepo.getCurrencyAbbreviation();

  String get getDateFormat => _homeRepo.getDateFormat();
}
