import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/all_transactions/logic/cubit/all_transactions_cubit.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> allDates =
        context.read<AllTransactionsCubit>().pageDates;
    return Text(
      DateFormat.yMMMM().format(allDates[pageIndex]),
      style: TextStyles.f20PrimaryDarkBold,
    );
  }
}
