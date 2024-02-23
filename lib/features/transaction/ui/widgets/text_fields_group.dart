import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/transaction/ui/widgets/date_icon.dart';

class TextFieldsGroup extends StatelessWidget {
  const TextFieldsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();
    return Column(
      children: [
        AppTextFormField(
          title: 'Title',
          controller: transactionCubit.titleController,
          hintText: 'Shopping, Salary, etc.',
        ),
        AppTextFormField(
            title: 'Amount',
            keyboardType: TextInputType.number,
            controller: transactionCubit.amountController,
            hintText: '0.00',
            onChanged: (value) {
              _updateTotalBalanceInstantly(value, context);
            }),
        AppTextFormField(
          title: 'Date',
          keyboardType: TextInputType.datetime,
          controller: transactionCubit.dateController,
          hintText: 'YYYY-MM-DD',
          icon: GestureDetector(
            onTap: () async {
              final DateTime? picked = await _showDatePickerDialog(context);
              _updateDateTextFormField(picked, context);
            },
            child: DateIcon(
              size: 30,
              color: AppColors.lightPrimaryColor,
              dateController: transactionCubit.dateController,
            ),
          ),
          onChanged: (value) {
            context.read<TransactionCubit>().isValidDate(value);
          },
        ),
        AppTextFormField(
          title: 'Note (Optional)',
          controller: transactionCubit.noteController,
          hintText: 'To be remembered',
          keyboardType: TextInputType.multiline,
          isRequired: false,
        )
      ],
    );
  }

  void _updateDateTextFormField(DateTime? picked, BuildContext context) {
    if (picked == null) return;
    final transactionCubit = context.read<TransactionCubit>();
    String stringPickedDate = picked.toString();
    String dateToDisplay = context
        .read<TransactionCubit>()
        .splitWantedDateFragment(stringPickedDate);
    transactionCubit.dateController.text = dateToDisplay;
    transactionCubit.isValidDate(dateToDisplay);
  }

  void _updateTotalBalanceInstantly(String value, BuildContext context) {
    print('value: $value ');
    final double? transactionAmount = double.tryParse(value);
    final transactionCubit = context.read<TransactionCubit>();
    final backCardCubit = context.read<BankCardCubit>();
    final String transactionType = transactionCubit.typeController.text;
    transactionAmount != null
        ? backCardCubit.instantlyUpdateBankCardValues(
            transactionAmount, transactionType)
        : backCardCubit.instantlyUpdateBankCardValues(0, transactionType);
  }

  Future<DateTime?> _showDatePickerDialog(BuildContext context) async {
    return showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white.withOpacity(1),
              onSurface: AppColors.lightPrimaryColor,
              onBackground: AppColors.lightPrimaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
      barrierColor: AppColors.primaryDarkColor.withOpacity(0.50),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
      lastDate: DateTime.now(),
    );
  }
}
