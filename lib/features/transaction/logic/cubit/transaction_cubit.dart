import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/transaction/data/repos/transaction_repo.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepo _transactionRepo;
  TransactionCubit(this._transactionRepo) : super(const TransactionInitial());

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController attachmentPathController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void setupTransactionControllers() {
    typeController.text = 'Expense';
    categoryController.text = 'Shopping';
  }

  void processTransaction() {
    emit(const TransactionComposing());

    final isValidatedDate = isValidDate(dateController.text);
    final isValidatedAmount = isValidAmount(amountController.text);

    if (!isValidatedDate || !isValidatedAmount) {
      final currentState = state;
      if (!isValidatedAmount) {
        emit(const TransactionErrorState(
            error: 'Invalid Amount, Please enter a numerical amount',
            errorCode: 400));
        emit(const TransactionComposing()
            .copyWith(currentState, isValidAmount: false));
        return;
      }

      emit(const TransactionErrorState(
          error:
              'Invalid Date, Please enter a valid date or pick corrected date directly',
          errorCode: 400));
      emit(const TransactionComposing()
          .copyWith(currentState, isValidDate: false));
      return;
    }

    saveTransaction();

    // if (isValidatedDate && isValidatedAmount) {
    //   emit(const TransactionComposing(isValidAmount: true, isValidDate: true));
    //   // saveTransaction();
    // }

    // print('${dateController.text} date from processTransaction');
    // print('${amountController.text} amount from processTransaction');
    // print('${typeController.text} type from processTransaction');
    // print('${categoryController.text} category from processTransaction');
    // print('${noteController.text} note from processTransaction');
    // print(
    //     '${attachmentPathController.text} attachment from processTransaction');
    // print('Saving Transaction...');
    // saveTransaction();
  }

  double? _toNumericAmount(String stringAmount) {
    return double.tryParse(stringAmount);
  }

  String? _toDateFormat(String stringDate) {
    final String wantedDateFragment = splitWantedDateFragment(stringDate);
    final List<String> stringDateFragments = wantedDateFragment.split('-');
    if (stringDateFragments.length != 3 ||
        stringDateFragments[0].length != 4 ||
        stringDateFragments[1].length != 2 ||
        stringDateFragments[2].length != 2) {
      return null;
    }
    final List<int?>? intDateFragments =
        _checkIntDateFormat(stringDateFragments);
    final bool isValidDateValues = intDateFragments != null;

    if (!isValidDateValues) {
      return null;
    }

    final String validDate = intDateFragments.join('-');
    final String formattedDate = validDate
        .split('-')
        .map((dateFragment) =>
            dateFragment.length == 1 ? '0$dateFragment' : dateFragment)
        .join('-');
    return formattedDate;
  }

  String splitWantedDateFragment(String stringDate) {
    return stringDate.trim().split(' ').first;
  }

  List<int?>? _checkIntDateFormat(List<String> dateFragments) {
    final List<int?> intFragmentsList = dateFragments
        .map((stringDateFragment) => int.tryParse(stringDateFragment))
        .toList();
    if (intFragmentsList.contains(null) ||
        intFragmentsList[0]! < 2000 ||
        intFragmentsList.contains(0) ||
        intFragmentsList[1]! > 12 ||
        intFragmentsList[2]! > 31) {
      return null;
    }
    return intFragmentsList;
  }

  bool isValidDate(String date) {
    final String? formattedDate = _toDateFormat(date);
    if (formattedDate == null) {
      // print('Invalid Date');
      emit(const TransactionComposing().copyWith(state, isValidDate: false));
      return false;
    }
    dateController.text = formattedDate;
    emit(const TransactionComposing().copyWith(state, isValidDate: true));
    return true;
  }

  bool isValidAmount(String amount) {
    final double? formattedAmount = _toNumericAmount(amount);
    if (formattedAmount == null) {
      // print('Invalid Amount');
      emit(const TransactionComposing().copyWith(state, isValidAmount: false));
      return false;
    }
    amountController.text = formattedAmount.toStringAsFixed(2);
    emit(const TransactionComposing().copyWith(state, isValidAmount: true));
    return true;
  }

  bool isAttachmentPicked() {
    if (attachmentPathController.text.isEmpty) {
      emit(const TransactionComposing()
          .copyWith(state, isAttachmentPicked: false));
      return false;
    }
    emit(
        const TransactionComposing().copyWith(state, isAttachmentPicked: true));
    return true;
  }

  bool isWithNote() {
    if (noteController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  Future<bool> isUserEnteredData() {
    return Future(() =>
        titleController.text.trim().isNotEmpty ||
        amountController.text.trim().isNotEmpty ||
        dateController.text.trim().isNotEmpty ||
        noteController.text.trim().isNotEmpty ||
        attachmentPathController.text.isNotEmpty);
  }

  void saveTransaction() {
    emit(const TransactionSaving());
    final isAttachmentAttached = isAttachmentPicked();
    final isNoteAttached = isWithNote();
    final Transaction newTransaction = Transaction(
      title: titleController.text,
      amount: double.parse(amountController.text),
      date: DateTime.parse(dateController.text).toUtc(),
      category: Category(
        name: categoryController.text,
        colorCode: Colors.blueAccent.value,
      ),
      transactionType: typeController.text == 'Expense'
          ? TransactionType.expense
          : TransactionType.income,
      note: isNoteAttached ? noteController.text : null,
      attachmentPath:
          isAttachmentAttached ? attachmentPathController.text : null,
    );
    try {
      _transactionRepo.saveTransaction(newTransaction);
      emit(
        TransactionSaved(
            message:
                "${newTransaction.title} Transaction Saved to Your ${newTransaction.transactionType}!"),
      );
    } catch (e) {
      emit(const TransactionErrorState(
          error: 'Error Saving Transaction', errorCode: 500));
    }
    // print('Saving Transaction...');
  }
}
