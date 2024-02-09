import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/routing/app_router.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/features/verification/data/repos/verification_repo.dart';

class MoneyManagerApp extends StatelessWidget {
  final AppRouter appRouter;
  final VerificationRepo verificationRepo;
  const MoneyManagerApp({
    super.key,
    required this.appRouter,
    required this.verificationRepo,
  });

  @override
  Widget build(BuildContext context) {
    final isUserExist = verificationRepo.userExistence();
    return ScreenUtilInit(
      designSize: const Size(420, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: "Moneyist",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute:
            isUserExist ? Routes.verificationScreen : Routes.onBoardingScreen,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
