part of 'transaction_cubit.dart';

@immutable
abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionComposing extends TransactionState {
  final bool? isValidAmount;
  final bool? isValidDate;
  final bool? isAttachmentPicked;

  const TransactionComposing(
      {this.isAttachmentPicked, this.isValidAmount, this.isValidDate});

  TransactionComposing copyWith(TransactionState currentState,
      {bool? isValidAmount, bool? isValidDate, bool? isAttachmentPicked}) {
    return currentState is TransactionComposing
        ? TransactionComposing(
            isValidAmount: isValidAmount ?? currentState.isValidAmount,
            isValidDate: isValidDate ?? currentState.isValidDate,
            isAttachmentPicked:
                isAttachmentPicked ?? currentState.isAttachmentPicked,
          )
        : TransactionComposing(
            isValidAmount: isValidAmount,
            isValidDate: isValidDate,
            isAttachmentPicked: isAttachmentPicked,
          );
  }
}

class TransactionEditing extends TransactionState {
  final Transaction transaction;

  const TransactionEditing({required this.transaction});
}

class TransactionSaving extends TransactionState {
  const TransactionSaving();
}

class TransactionSaved extends TransactionState {
  final String message;

  const TransactionSaved({required this.message});
}

class TransactionUpdated extends TransactionState {
  final String message;

  const TransactionUpdated({required this.message});
}

class TransactionErrorState extends TransactionState {
  final String error;
  final int errorCode;

  const TransactionErrorState({required this.error, required this.errorCode});
}
