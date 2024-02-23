part of 'bank_card_cubit.dart';

@immutable
abstract class BankCardState {
  const BankCardState();
}

class BankCardInitial extends BankCardState {
  const BankCardInitial();
}

class BankCardLoading extends BankCardState {
  const BankCardLoading();
}

class BankCardLoaded extends BankCardState {
  final double bankCardBalance;
  final double bankCardExpenses;
  final double bankCardIncomes;

  const BankCardLoaded(
      {required this.bankCardExpenses,
      required this.bankCardIncomes,
      required this.bankCardBalance});
}

class BankCardError extends BankCardState {
  final String error;
  final int errorCode;

  const BankCardError({required this.error, required this.errorCode});
}
