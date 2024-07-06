import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/statistics/cubit/statistics_cubit.dart';

class StatisticsToggleButton extends StatefulWidget {
  const StatisticsToggleButton({super.key});

  @override
  State<StatisticsToggleButton> createState() => _StatisticsToggleButtonState();
}

class _StatisticsToggleButtonState extends State<StatisticsToggleButton> {
  final selectedItems = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    final StatisticsCubit statisticsCubit = context.read<StatisticsCubit>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.cyanColor.withOpacity(0.50),
      ),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        fillColor: AppColors.primaryColor,
        selectedColor: Colors.white,
        textStyle: TextStyles.f16WhiteMedium.copyWith(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 16)),
        isSelected: selectedItems,
        constraints: BoxConstraints.expand(
          width: 195.w,
          height: 50.h,
        ),
        onPressed: (index) {
          for (int i = 0; i < selectedItems.length; i++) {
            setState(() {
              selectedItems[i] = i == index;
            });
          }
          statisticsCubit.loadStatistics(selectedItems[0]
              ? TransactionType.expense
              : TransactionType.income);
        },
        children: [
          Text(AppString.expense.tr()),
          Text(AppString.income.tr()),
        ],
      ),
    );
  }
}
