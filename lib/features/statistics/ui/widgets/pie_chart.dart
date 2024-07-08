import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/statistics/cubit/statistics_cubit.dart';
import 'package:money_manager/features/statistics/ui/widgets/indicator.dart';

class StatisticsPieChart extends StatelessWidget {
  const StatisticsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is StatisticsLoading) {
          return const CircularProgressIndicator();
        }
        state as StatisticsLoaded;
        final List<Category> categories =
            state.categoriesTransactionsMap.keys.toList();
        final Map<Category, double> categoriesPercentage = state.pieChartData;

        return Container(
          margin: EdgeInsets.only(top: 20.h),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 60,
                      sections: showingSections(context, categoriesPercentage),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: categories
                            .map((cat) => Indicator(
                                  title: cat.name,
                                  color: Color(cat.colorCode +
                                      cat.colorCode * 3 -
                                      10592673),
                                  shape: BoxShape.rectangle,
                                ))
                            .toList()),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSections(
      BuildContext context, Map<Category, double> categoriesPercentage) {
    List<PieChartSectionData> sections = [];
    categoriesPercentage.forEach((category, value) {
      sections.add(
        PieChartSectionData(
          color: Color(category.colorCode + category.colorCode * 3 - 10592673),
          value: value,
          title: '${value.toStringAsFixed(2)}%',
          radius: 50,
          titleStyle: TextStyle(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 12),
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDarkColor,
            shadows: const [Shadow(color: Colors.white, blurRadius: 2)],
          ),
        ),
      );
    });

    return sections;
  }
}
