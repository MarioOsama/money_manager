import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/statistics/cubit/statistics_cubit.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        state as StatisticsLoaded;
        final double maxY = state.lineChartData
                .reduce((value, element) => value > element ? value : element) *
            1.5;
        final int numberLength = maxY.toString().length - 2;
        final double doubleMaxY =
            maxY / int.parse('1${'0' * (numberLength - 1)}');
        final double maxYInt =
            doubleMaxY.ceil() * double.parse('1${'0' * (numberLength - 1)}');

        final chartData = [
          for (int i = 0; i < 30; i++)
            FlSpot(i.toDouble(), state.lineChartData[i])
        ];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColors.cyanColor.withOpacity(0.50),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.cyanColor.withOpacity(0.50),
                AppColors.primaryColor.withOpacity(0.50),
              ],
            ),
          ),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              maxY: maxYInt,
              maxX: 30,
              minY: 0,
              minX: 1,
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    width: 3,
                  ),
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameSize: width * 0.075,
                  axisNameWidget: Text(
                    'Amount',
                    style: TextStyles.f14PrimaryBold.copyWith(
                        fontSize: TextStyles.getResponsiveFontSize(context,
                            baseFontSize: 14)),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: width * 0.125,
                    getTitlesWidget: (value, meta) =>
                        buildLeftTitles(context, value, meta),
                  ),
                ),
                bottomTitles: AxisTitles(
                    axisNameSize: width * 0.05,
                    axisNameWidget: Text(
                      'Day',
                      style: TextStyles.f14PrimaryBold.copyWith(
                          fontSize: TextStyles.getResponsiveFontSize(context,
                              baseFontSize: 14)),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: width * 0.065,
                      getTitlesWidget: (value, meta) =>
                          buildBottomTitles(context, value, meta),
                    )),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                LineChartBarData(
                  preventCurveOverShooting: true,
                  spots: chartData,
                  isCurved: true,
                  barWidth: 4,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: true),
                  isStrokeCapRound: true,
                  color: state.isExpense
                      ? AppColors.lightRedColor
                      : AppColors.lightGreenColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLeftTitles(context, value, meta) => Text(
        value.toInt().toString(),
        style: TextStyles.f14PrimaryBold.copyWith(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 12)),
      );

  Widget buildBottomTitles(context, value, meta) => Text(
        value.toInt().toString(),
        style: TextStyles.f14PrimaryBold.copyWith(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 12)),
      );
}
