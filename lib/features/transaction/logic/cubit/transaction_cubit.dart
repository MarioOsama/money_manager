import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/date.dart';
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
  Transaction? transactionToEdit;

  void setupTransactionControllers() {
    typeController.text = 'Expense';
    categoryController.text = 'Shopping';
  }

  void processTransaction(bool isEditing) {
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

    if (isEditing) {
      updateTransaction();
      return;
    }
    saveTransaction();
  }

  double? _toNumericAmount(String stringAmount) {
    return double.tryParse(stringAmount);
  }

  bool isValidDate(String date) {
    final String? formattedDate = DateHelper.toDateFormat(date);
    if (formattedDate == null) {
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
      emit(const TransactionComposing().copyWith(state, isValidAmount: false));
      return false;
    }
    amountController.text = formattedAmount.toStringAsFixed(2);
    emit(const TransactionComposing().copyWith(state, isValidAmount: true));
    return true;
  }

  void changeAttachmentState() {
    if (state is TransactionEditing) {
      emit(TransactionEditing(
          transaction: (state as TransactionEditing).transaction.copyWith(
                attachmentPath: attachmentPathController.text.isEmpty
                    ? null
                    : attachmentPathController.text,
              )));
      return;
    }
    if (attachmentPathController.text.isEmpty) {
      emit(const TransactionComposing()
          .copyWith(state, isAttachmentPicked: false));
      return;
    }
    emit(
        const TransactionComposing().copyWith(state, isAttachmentPicked: true));
  }

  bool isWithNote() {
    if (noteController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  bool isUserEnteredData() {
    return titleController.text.trim().isNotEmpty ||
        amountController.text.trim().isNotEmpty ||
        dateController.text.trim().isNotEmpty ||
        noteController.text.trim().isNotEmpty ||
        attachmentPathController.text.isNotEmpty;
  }

  String? get getAttachmentPath {
    return attachmentPathController.text.isNotEmpty
        ? attachmentPathController.text
        : null;
  }

  String? get getNote {
    return isWithNote() ? noteController.text : null;
  }

  void saveTransaction() {
    emit(const TransactionSaving());
    handleControllers();
    final attachmentPath = getAttachmentPath;
    final note = getNote;
    final categoryName = categoryController.text;
    final Transaction newTransaction = Transaction(
      title: titleController.text,
      amount: double.parse(amountController.text),
      date: DateTime.parse(dateController.text).toLocal().add(
            Duration(
              hours: DateTime.now().hour,
              minutes: DateTime.now().minute,
              seconds: DateTime.now().second,
            ),
          ),
      categoryName: categoryName,
      transactionType: typeController.text == 'Expense'
          ? TransactionType.expense
          : TransactionType.income,
      note: note,
      attachmentPath: attachmentPath,
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
  }

  void setupEditingTransactionEnvironment(Transaction currentTransaction) {
    emit(TransactionEditing(transaction: currentTransaction));
    transactionToEdit = currentTransaction;

    titleController.text = currentTransaction.title;
    amountController.text = currentTransaction.amount.toStringAsFixed(2);
    final String formattedDate =
        DateHelper.toDateFormat(currentTransaction.date.toString())!;
    dateController.text = formattedDate;
    typeController.text =
        currentTransaction.transactionType == TransactionType.expense
            ? 'Expense'
            : 'Income';
    categoryController.text = currentTransaction.categoryName;
    noteController.text = currentTransaction.note ?? '';
    attachmentPathController.text = currentTransaction.attachmentPath ?? '';
  }

  void updateTransaction() {
    handleControllers();
    final Transaction updatedTransaction = transactionToEdit!.copyWith(
      title: titleController.text,
      amount: double.parse(amountController.text),
      date: DateTime.parse(dateController.text).toLocal().add(
            Duration(
              hours: DateTime.now().hour,
              minutes: DateTime.now().minute,
              seconds: DateTime.now().second,
            ),
          ),
      categoryName: categoryController.text,
      transactionType: typeController.text == 'Expense'
          ? TransactionType.expense
          : TransactionType.income,
      note: noteController.text.isEmpty ? '' : noteController.text,
      attachmentPath: attachmentPathController.text.isEmpty
          ? ''
          : attachmentPathController.text,
    );
    try {
      _transactionRepo.updateTransaction(updatedTransaction);
      emit(
        TransactionSaved(
            message:
                "${updatedTransaction.title} Transaction Updated in Your ${updatedTransaction.transactionType}!"),
      );
    } catch (e) {
      emit(const TransactionErrorState(
          error: 'Error Updating Transaction', errorCode: 500));
    }
  }

  void handleControllers() {
    typeController.text = typeController.text.replaceFirst('(', '');
    typeController.text = typeController.text.replaceFirst(')', '');
    categoryController.text = categoryController.text.replaceFirst('(', '');
    categoryController.text = categoryController.text.replaceFirst(')', '');
  }
}
