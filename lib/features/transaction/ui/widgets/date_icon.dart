import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<TransactionCubit, TransactionState>(
      buildWhen: (previous, current) => current is TransactionComposing,
      builder: (context, state) {
        final isValidDate =
            state is TransactionComposing ? state.isValidDate ?? false : false;
        return Icon(
          isValidDate ? Icons.calendar_month : Icons.calendar_today_outlined,
          size: size,
          color: isValidDate ? color : null,
        );
      },
    );
  }
}
