import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/features/categories/logic/cubit/categories_cubit.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';
import 'package:money_manager/features/onboarding/on_boarding_screen.dart';
import 'package:money_manager/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:money_manager/features/reset_password/ui/reset_password.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/transaction/ui/transaction_screen.dart';
import 'package:money_manager/features/transaction_details/data/repos/transaction_details_repo.dart';
import 'package:money_manager/features/transaction_details/ui/transaction_details_screen.dart';
import 'package:money_manager/features/verification/ui/verification_screen.dart';
import 'package:money_manager/features/verification/logic/cubit/verification_cubit.dart';
import 'package:money_manager/main_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case Routes.verificationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<VerificationCubit>(
            create: (context) => getIt<VerificationCubit>(),
            child: const VerificationScreen(),
          ),
        );
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeCubit>(
            create: (context) => getIt<HomeCubit>(),
            child: const MainScreen(),
          ),
        );
      case Routes.transactionScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<TransactionCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<CategoriesCubit>(),
              ),
            ],
            child: TransactionScreen(
              transaction: args as Transaction?,
            ),
          ),
        );
      case Routes.transactionDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => TransactionDetailsScreen(
            transactionDetailsRepo: getIt<TransactionDetailsRepo>(),
            transaction: args as Transaction,
          ),
        );
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ResetPasswordCubit>(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: const ResetPasswordScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          // return no route found message
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
