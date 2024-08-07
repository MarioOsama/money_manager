import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/date.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/transaction/ui/widgets/date_icon.dart';

class TextFieldsGroup extends StatelessWidget {
  final bool isEditing;
  const TextFieldsGroup({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();
    return Column(
      children: [
        AppTextFormField(
          title: AppString.title.tr(),
          controller: transactionCubit.titleController,
          hintText: AppString.titleExample.tr(),
        ),
        AppTextFormField(
            title: AppString.amount.tr(),
            keyboardType: TextInputType.number,
            controller: transactionCubit.amountController,
            hintText: '0.00',
            onChanged: (value) {
              isEditing ? null : _updateTotalBalanceInstantly(value, context);
            }),
        AppTextFormField(
          title: AppString.date.tr(),
          keyboardType: TextInputType.datetime,
          controller: transactionCubit.dateController,
          hintText: AppString.dMYFormat.tr(),
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
          title: AppString.noteOptional.tr(),
          controller: transactionCubit.noteController,
          hintText: AppString.noteExample.tr(),
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
    String dateToDisplay = DateHelper.splitWantedDateFragment(stringPickedDate);
    transactionCubit.dateController.text = dateToDisplay;
    transactionCubit.isValidDate(dateToDisplay);
  }

  void _updateTotalBalanceInstantly(String value, BuildContext context) {
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
