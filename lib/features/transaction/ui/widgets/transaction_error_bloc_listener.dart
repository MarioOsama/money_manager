import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class TransactionErrorBlocListener extends StatelessWidget {
  const TransactionErrorBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionCubit, TransactionState>(
      listenWhen: (previous, current) =>
          previous != current && current is TransactionErrorState,
      listener: (context, state) {
        if (state is TransactionErrorState) {
          final error = state.error;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: AppColors.lightPrimaryColor,
              title: Text(
                'Error',
                style: TextStyles.f20RedBold,
              ),
              content: Text(
                error,
                style: TextStyles.f16PrimaryMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Got it',
                    style: TextStyles.f16LightPrimaryMedium,
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
