import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/widgets/app_drop_down_menu_item.dart';
import 'package:money_manager/features/categories/cubit/categories_cubit.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class DropDownMenuItemsRow extends StatelessWidget {
  const DropDownMenuItemsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();
    final typeController = transactionCubit.typeController;
    final categoryController = transactionCubit.categoryController;
    final categoriesCubit = context.read<CategoriesCubit>();
    categoriesCubit.loadCategories();
    final categories = (categoriesCubit.state as CategoriesLoaded).categories;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppDropDownMenuItem(
          title: 'Transaction Type',
          items: const [TransactionType.expense, TransactionType.income],
          controller: typeController,
          onChanged: _onTransactionTypeChanged,
          itemColors: const [
            AppColors.lightRedColor,
            AppColors.lightGreenColor,
          ],
        ),
        AppDropDownMenuItem(
          title: 'Transaction Category',
          items: categories,
          controller: categoryController,
          itemsHaveColorProperty: true,
        ),
      ],
    );
  }

  void _onTransactionTypeChanged(
      BuildContext context, TextEditingController controller) {
    final double? newTransactionAmount =
        double.tryParse(context.read<TransactionCubit>().amountController.text);
    final bankCardCubit = context.read<BankCardCubit>();
    newTransactionAmount != null
        ? bankCardCubit.instantlyUpdateBankCardValues(
            newTransactionAmount, controller.text)
        : bankCardCubit.instantlyUpdateBankCardValues(0, controller.text);
  }
}
