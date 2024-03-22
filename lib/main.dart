import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/routing/app_router.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/verification/data/repos/verification_repo.dart';
import 'package:money_manager/money_manager_app.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();

  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter(DatabaseConstants.dbName);
  // await Hive.deleteBoxFromDisk(DatabaseConstants.userBox);
  // await Hive.deleteBoxFromDisk(DatabaseConstants.categoriesBox);
  // await Hive.deleteBoxFromDisk(DatabaseConstants.transactionsBox);
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox(DatabaseConstants.userBox);
  await Hive.openBox(DatabaseConstants.transactionsBox);
  await Hive.openBox(DatabaseConstants.categoriesBox);

  await Future.delayed(const Duration(milliseconds: 1000));

  runApp(
    BlocProvider(
      create: (context) => getIt<BankCardCubit>(),
      child: MoneyManagerApp(
        appRouter: AppRouter(),
        verificationRepo: getIt<VerificationRepo>(),
      ),
    ),
  );
}
