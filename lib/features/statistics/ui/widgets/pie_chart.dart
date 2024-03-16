import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/features/statistics/ui/widgets/indicator.dart';

class StatisticsPieChart extends StatelessWidget {
  const StatisticsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        // color: AppColors.primaryColor,
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryDarkColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 5,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                  title: 'Category 1',
                  color: Colors.yellow,
                  shape: BoxShape.rectangle),
              SizedBox(
                height: 4,
              ),
              Indicator(
                  title: 'Category 2',
                  color: Colors.yellow,
                  shape: BoxShape.rectangle),
              SizedBox(
                height: 4,
              ),
              Indicator(
                  title: 'Category 3',
                  color: Colors.yellow,
                  shape: BoxShape.rectangle),
              SizedBox(
                height: 4,
              ),
              Indicator(
                  title: 'Category 4',
                  color: Colors.yellow,
                  shape: BoxShape.rectangle),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      const double fontSize = 16.0;
      const double radius = 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.cyanColor,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.lightGreenColor,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.pinkColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.primaryColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
