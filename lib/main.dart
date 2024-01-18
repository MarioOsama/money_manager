import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/routing/app_router.dart';
import 'package:money_manager/features/verification/data/repos/verification_repo.dart';
import 'package:money_manager/money_manager_app.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();

  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter(DatabaseConstants.dbName);
  // await Hive.deleteBoxFromDisk(DatabaseConstants.verBox);
  await Hive.openBox(DatabaseConstants.verBox);
  await Hive.openBox(DatabaseConstants.expensesBox);
  runApp(
    MoneyManagerApp(
      appRouter: AppRouter(),
      verificationRepo: getIt<VerificationRepo>(),
    ),
  );
}
