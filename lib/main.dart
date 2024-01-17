import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/routing/app_router.dart';
import 'package:money_manager/features/verification/data/repos/verification_repo.dart';
import 'package:money_manager/money_manager_app.dart';

void main() async {
  setupGetIt();
  await Hive.initFlutter();
  await Hive.openBox(DatabaseConstants.boxName);
  runApp(
    MoneyManagerApp(
      appRouter: AppRouter(),
      verificationRepo: getIt<VerificationRepo>(),
    ),
  );
}
