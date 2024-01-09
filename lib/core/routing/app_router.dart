import 'package:flutter/material.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/features/onboarding/on_boarding_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return const OnBoardingScreen();
          },
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
