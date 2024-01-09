import 'package:flutter/material.dart';
import 'package:money_manager/core/routing/app_router.dart';
import 'package:money_manager/money_manager_app.dart';

void main() {
  runApp(
    MoneyManagerApp(
      appRouter: AppRouter(),
    ),
  );
}
