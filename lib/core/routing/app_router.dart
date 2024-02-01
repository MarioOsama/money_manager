import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/features/home/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/home/ui/home_screen.dart';
import 'package:money_manager/features/onboarding/on_boarding_screen.dart';
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
          builder: (_) => BlocProvider<TransactionCubit>(
            create: (context) => getIt<TransactionCubit>(),
            child: const MainScreen(),
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
