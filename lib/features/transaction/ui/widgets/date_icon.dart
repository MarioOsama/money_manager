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
    bool isValidDate = false;
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionComposing) {
          isValidDate = state.isValidDate ?? false;
        } else if (state is TransactionEditing) {
          final String? validatedDate =
              DateHelper.toDateFormat(dateController.text);
          isValidDate = validatedDate != null ? true : false;
        } else {
          isValidDate = false;
        }

        return Icon(
          isValidDate ? Icons.calendar_month : Icons.calendar_today_outlined,
          size: size,
          color: isValidDate ? color : null,
        );
      },
    );
  }
}
