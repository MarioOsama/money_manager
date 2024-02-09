import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/widgets/app_drop_down_menu_item.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class DropDownMenuItemsRow extends StatelessWidget {
  const DropDownMenuItemsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();
    final typeController = transactionCubit.typeController;
    final categoryController = transactionCubit.categoryController;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppDropDownMenuItem(
          title: 'Transaction Type',
          items: const [TransactionType.expense, TransactionType.income],
          controller: typeController,
          onChanged: _onChanged,
          itemColors: const [
            Color(0xFFD45F5F),
            Color(0xFF5F6DD4),
          ],
        ),
        AppDropDownMenuItem(
          title: 'Transaction Category',
          items: [
            Category(
                name: 'Shopping', colorCode: const Color(0xFFC3D0E6).value),
            Category(name: 'Online', colorCode: const Color(0xFFC3E6C4).value),
          ],
          controller: categoryController,
          itemsHaveColorProperty: true,
        ),
      ],
    );
  }

  void _onChanged(BuildContext context, TextEditingController controller) {
    final double? newTransactionAmount =
        double.tryParse(context.read<TransactionCubit>().amountController.text);
    final bankCardCubit = context.read<BankCardCubit>();
    newTransactionAmount != null
        ? bankCardCubit.instantlyUpdateBankCardValues(
            newTransactionAmount, controller.text)
        : bankCardCubit.instantlyUpdateBankCardValues(0, controller.text);
  }
}
