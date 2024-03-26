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
            2;
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Last 30 Days Overview',
                  style: TextStyles.f24PrimaryBold
                      .copyWith(letterSpacing: 1.5, wordSpacing: 2),
                  textAlign: TextAlign.center,
                ),
              ),
              AspectRatio(
                aspectRatio: 1.8,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    maxY: maxY,
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
                          style: TextStyles.f14PrimaryBold,
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: width * 0.125,
                          getTitlesWidget: buildLeftTitles,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                          axisNameSize: width * 0.05,
                          axisNameWidget: Text(
                            'Day',
                            style: TextStyles.f14PrimaryBold,
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: width * 0.065,
                            getTitlesWidget: buildBottomTitles,
                          )),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        preventCurveOverShooting: true,
                        spots: chartData,
                        isCurved: true,
                        barWidth: 4,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        isStrokeCapRound: true,
                        color: state.isExpense
                            ? AppColors.lightRedColor
                            : AppColors.lightGreenColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildLeftTitles(value, meta) => Text(
        value.toInt().toString(),
        style: TextStyles.f14PrimaryBold,
      );

  Widget buildBottomTitles(value, meta) => Text(
        value.toInt().toString(),
        style: TextStyles.f14PrimaryBold,
      );
}
