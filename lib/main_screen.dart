import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/categories/cubit/categories_cubit.dart';
import 'package:money_manager/features/categories/ui/gategories_screen.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';
import 'package:money_manager/features/home/ui/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _tabIndex = 0;

  final Map<String, Widget> _bodiesList = {
    'Home': const HomeScreen(),
    'Statistics': const Center(child: Text('Statistics Screen')),
    'Categories': BlocProvider(
      create: (context) => getIt<CategoriesCubit>(),
      child: const CategoriesScreen(),
    ),
    'Settings': const Center(child: Text('Settings Screen')),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tabIndex != 0
          ? AppBar(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryDarkColor,
              elevation: 0,
              titleSpacing: -40.w,
              title: Text(
                _bodiesList.keys.toList()[_tabIndex],
                style: TextStyles.f20PrimaryDarkSemiBold,
              ),
              leading: const SizedBox.shrink(),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  iconSize: 30.sp,
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: _bodiesList.values.toList()[_tabIndex],
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
    );
  }
}
