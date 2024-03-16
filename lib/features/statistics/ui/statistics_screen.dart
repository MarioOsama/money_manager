import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/statistics/ui/widgets/line_chart.dart';
import 'package:money_manager/features/statistics/ui/widgets/pie_chart.dart';
import 'package:money_manager/features/statistics/ui/widgets/statistics_toggle_button.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CustomAppBar(title: 'Financial Report'),
        const StatisticsPieChart(),
        verticalSpace(30),
        const StatisticsToggleButton(),
        verticalSpace(20),
        const LineChartSample1(),
      ],
    );
  }
}
