import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/features/statistics/cubit/statistics_cubit.dart';
import 'package:money_manager/features/statistics/ui/statistics_screen.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/features/categories/logic/cubit/categories_cubit.dart';
import 'package:money_manager/features/categories/ui/categories_screen.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';
import 'package:money_manager/features/home/ui/home_screen.dart';
import 'package:money_manager/features/settings/ui/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _tabIndex = 0;

  final Map<String, Widget> _bodiesList = {
    'Home': const HomeScreen(),
    'Statistics': BlocProvider<StatisticsCubit>(
      create: (context) => getIt<StatisticsCubit>(),
      child: const StatisticsScreen(),
    ),
    'Categories': BlocProvider<CategoriesCubit>(
      create: (context) => getIt<CategoriesCubit>(),
      child: const CategoriesScreen(),
    ),
    'Settings': const SettingsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Container()),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: _bodiesList.values.toList()[_tabIndex],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomAppBar(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            notchMargin: 7.r,
            surfaceTintColor: Colors.white,
            shape: const CircularNotchedRectangle(),
            height: 60.h,
            elevation: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _tabIndex = 0;
                      context.read<HomeCubit>().tabIndexController.text = '0';
                    });
                  },
                  icon: const Icon(Icons.receipt_long_outlined),
                  color: _tabIndex == 0
                      ? AppColors.lightPrimaryColor
                      : AppColors.primaryDarkColor.withOpacity(0.50),
                  iconSize: _tabIndex == 0 ? 35.sp : 25.sp,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _tabIndex = 1;
                      context.read<HomeCubit>().tabIndexController.text = '1';
                    });
                  },
                  icon: const Icon(Icons.insert_chart_outlined_rounded),
                  color: _tabIndex == 1
                      ? AppColors.lightPrimaryColor
                      : AppColors.primaryDarkColor.withOpacity(0.50),
                  iconSize: _tabIndex == 1 ? 40.sp : 30.sp,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _tabIndex = 2;
                      context.read<HomeCubit>().tabIndexController.text = '2';
                    });
                  },
                  icon: const Icon(Icons.category_outlined),
                  color: _tabIndex == 2
                      ? AppColors.lightPrimaryColor
                      : AppColors.primaryDarkColor.withOpacity(0.50),
                  iconSize: _tabIndex == 2 ? 40.sp : 30.sp,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _tabIndex = 3;
                      context.read<HomeCubit>().tabIndexController.text = '3';
                    });
                  },
                  icon: const Icon(Icons.settings_outlined),
                  color: _tabIndex == 3
                      ? AppColors.lightPrimaryColor
                      : AppColors.primaryDarkColor.withOpacity(0.50),
                  iconSize: _tabIndex == 3 ? 40.sp : 30.sp,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(Routes.transactionScreen);
          },
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          splashColor: Colors.black,
          shape: const CircleBorder(),
          elevation: 20,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    // final isTouched = i == touchedIndex;
    // final fontSize = isTouched ? 25.0 : 16.0;
    // final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: AppColors.primaryColor,
          value: 40,
          title: '40%',
          radius: 16,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: AppColors.cyanColor,
          value: 30,
          title: '30%',
          radius: 16,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: AppColors.redColor,
          value: 15,
          title: '15%',
          radius: 16,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: AppColors.lightGreenColor,
          value: 15,
          title: '15%',
          radius: 16,
          titleStyle: TextStyle(
            fontSize: 16,
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
