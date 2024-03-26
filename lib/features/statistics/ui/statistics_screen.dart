import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/statistics/cubit/statistics_cubit.dart';
import 'package:money_manager/features/statistics/ui/widgets/line_chart.dart';
import 'package:money_manager/features/statistics/ui/widgets/pie_chart.dart';
import 'package:money_manager/features/statistics/ui/widgets/statistics_toggle_button.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StatisticsCubit statisticsCubit = context.read<StatisticsCubit>();
    statisticsCubit.loadStatistics(TransactionType.expense);
    return Column(
      children: <Widget>[
        const CustomAppBar(title: 'Financial Report'),
        verticalSpace(10),
        const Expanded(
          flex: 1,
          child: StatisticsToggleButton(),
        ),
        verticalSpace(20),
        const Expanded(
          flex: 6,
          child: StatisticsPieChart(),
        ),
        verticalSpace(30),
        const Expanded(
          flex: 6,
          child: LineChartWidget(),
        ),
        verticalSpace(30),
      ],
    );
  }
}
