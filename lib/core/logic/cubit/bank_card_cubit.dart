import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_manager/core/data/repos/bank_card_repo.dart';
import 'package:money_manager/core/models/transaction.dart';

part 'bank_card_state.dart';

class BankCardCubit extends Cubit<BankCardState> {
  final BankCardRepo _bankCardRepo;

  BankCardCubit(this._bankCardRepo) : super(const BankCardInitial());

  void updateBankCardData() {
    emit(const BankCardLoading());
    try {
      _bankCardRepo.loadTransactionsFromDatabase();
      _bankCardRepo.filteTransactionsByType();
      _setBankCardValues();
    } catch (e) {
      _emitError(e);
    }
  }

  void updateBankCardDataOnDeleteTransaction(Transaction transaction) {
    final transactionType = transaction.transactionType;
    if (transactionType == TransactionType.expense) {
      emit(
        BankCardLoaded(
            bankCardExpenses: ((state as BankCardLoaded).bankCardExpenses -
                    transaction.amount)
                .abs(),
            bankCardIncomes: (state as BankCardLoaded).bankCardIncomes,
            bankCardBalance: (state as BankCardLoaded).bankCardIncomes -
                (state as BankCardLoaded).bankCardExpenses +
                transaction.amount),
      );
    } else {
      emit(
        BankCardLoaded(
            bankCardExpenses: (state as BankCardLoaded).bankCardExpenses,
            bankCardIncomes:
                ((state as BankCardLoaded).bankCardIncomes - transaction.amount)
                    .abs(),
            bankCardBalance: (state as BankCardLoaded).bankCardIncomes -
                transaction.amount -
                (state as BankCardLoaded).bankCardExpenses),
      );
    }
  }

  void updateBankCardDataOnRestoreTransaction(Transaction transaction) {
    final transactionType = transaction.transactionType;
    if (transactionType == TransactionType.expense) {
      emit(
        BankCardLoaded(
            bankCardExpenses: ((state as BankCardLoaded).bankCardExpenses +
                    transaction.amount)
                .abs(),
            bankCardIncomes: (state as BankCardLoaded).bankCardIncomes,
            bankCardBalance: (state as BankCardLoaded).bankCardIncomes -
                (state as BankCardLoaded).bankCardExpenses -
                transaction.amount),
      );
    } else {
      emit(
        BankCardLoaded(
            bankCardExpenses: (state as BankCardLoaded).bankCardExpenses,
            bankCardIncomes:
                ((state as BankCardLoaded).bankCardIncomes + transaction.amount)
                    .abs(),
            bankCardBalance: (state as BankCardLoaded).bankCardIncomes +
                transaction.amount -
                (state as BankCardLoaded).bankCardExpenses),
      );
    }
  }

  double getExpensesAmount() => _bankCardRepo.getExpensesAmount();

  double getIncomesAmount() => _bankCardRepo.getIncomesAmount();

  List<double> calculateBankCardValues() {
    final double bankCardExpenses = getExpensesAmount();
    final double bankCardIncomes = getIncomesAmount();
    return [
      bankCardIncomes - bankCardExpenses,
      bankCardExpenses,
      bankCardIncomes
    ];
  }

  void instantlyUpdateBankCardValues(
      double newTransactionAmount, String transactionType) {
    double expensesAmount = getExpensesAmount();
    double incomesAmount = getIncomesAmount();
    double bankCardBalance = incomesAmount - expensesAmount;
    transactionType = transactionType.replaceAll('(', '');
    transactionType = transactionType.replaceAll(')', '');
    if (transactionType == 'Expense') {
      _refreshBankCardWithValues(bankCardBalance - newTransactionAmount,
          expensesAmount + newTransactionAmount, incomesAmount);
    } else {
      _refreshBankCardWithValues(bankCardBalance + newTransactionAmount,
          expensesAmount, incomesAmount + newTransactionAmount);
    }
  }

  void _setBankCardValues() {
    final bankCardValues = calculateBankCardValues();
    if (bankCardValues.contains(null)) {
      _emitError("Unexpected Error");
    } else {
      _refreshBankCardWithValues(
          bankCardValues[0], bankCardValues[1], bankCardValues[2]);
    }
  }

  void _refreshBankCardWithValues(
      double bankCardBalance, double bankCardExpenses, double bankCardIncomes) {
    emit(BankCardLoaded(
        bankCardBalance: bankCardBalance,
        bankCardExpenses: bankCardExpenses,
        bankCardIncomes: bankCardIncomes));
  }

  void _emitError(dynamic error) {
    emit(BankCardError(error: error.toString(), errorCode: 500));
  }

  void resetBankCardData() {
    emit(const BankCardInitial());
  }

  String get getCurrencyAbbreviation => _bankCardRepo.getCurrencyAbbreviation;
}
