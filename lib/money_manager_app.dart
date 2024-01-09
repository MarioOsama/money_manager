import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/routing/app_router.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';

class MoneyManagerApp extends StatelessWidget {
  final AppRouter appRouter;
  const MoneyManagerApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 890),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: "Moneyist",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: Routes.onBoardingScreen,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
