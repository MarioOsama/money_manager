import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class SaveTransactionButton extends StatelessWidget {
  final bool isEditing;
  const SaveTransactionButton({
    super.key,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPress: () {
        isEditing
            ? _validateAndSaveChanges(context)
            : _validateAndSaveTransaction(context);
      },
      text: isEditing ? 'Save Changes' : 'Save Transaction',
    );
  }

  void _validateAndSaveTransaction(BuildContext context) {
    final form = context.read<TransactionCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<TransactionCubit>().processTransaction(false);
      final isSavedSuccessfuly =
          context.read<TransactionCubit>().state is TransactionSaved;
      if (isSavedSuccessfuly) {
        context.pushAndRemoveUntil(Routes.mainScreen, (route) => false);
      }
    }
  }

  _validateAndSaveChanges(BuildContext context) {
    final form = context.read<TransactionCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<TransactionCubit>().processTransaction(true);
      final isSavedSuccessfuly =
          context.read<TransactionCubit>().state is TransactionSaved;
      if (isSavedSuccessfuly) {
        context.pushAndRemoveUntil(Routes.mainScreen, (route) => false);
      }
    }
  }
}
