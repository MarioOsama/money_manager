import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/date.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class DateIcon extends StatelessWidget {
  final double size;
  final TextEditingController dateController;
  final Color? color;
  const DateIcon(
      {super.key,
      required this.size,
      this.color,
      required this.dateController});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TransactionCubit, TransactionState, bool?>(
      selector: (state) {
        if (state is TransactionComposing) {
          return state.isValidDate;
        } else if (state is TransactionEditing) {
          final String? validatedDate =
              DateHelper.toDateFormat(dateController.text);
          return validatedDate != null ? true : false;
        } else {
          return false;
        }
      },
      builder: (context, isValidDate) {
        return Icon(
          isValidDate! ? Icons.calendar_month : Icons.calendar_today_outlined,
          size: size,
          color: isValidDate ? color : null,
        );
      },
    );
  }
}
