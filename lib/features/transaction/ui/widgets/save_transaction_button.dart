import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class SaveTransactionButton extends StatelessWidget {
  const SaveTransactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPress: () {
        _validateAndSaveTransaction(context);
      },
      text: 'Save Transaction',
    );
  }

  void _validateAndSaveTransaction(BuildContext context) {
    final form = context.read<TransactionCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<TransactionCubit>().processTransaction();
      final isSavedSuccessfuly =
          context.read<TransactionCubit>().state is TransactionSaved;
      if (isSavedSuccessfuly) {
        context.pushReplacementNamed(Routes.mainScreen);
      }
    } else {}
  }
}
