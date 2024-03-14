import 'package:get_it/get_it.dart';
import 'package:money_manager/core/data/repos/bank_card_repo.dart';
import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/features/categories/logic/cubit/categories_cubit.dart';
import 'package:money_manager/features/categories/data/repos/categories_repo.dart';
import 'package:money_manager/features/home/data/repos/home_repo.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';
import 'package:money_manager/features/reset_password/data/repos/reset_password_repo.dart';
import 'package:money_manager/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:money_manager/features/transaction/data/repos/transaction_repo.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/transaction_details/data/repos/transaction_details_repo.dart';
import 'package:money_manager/features/verification/data/repos/verification_repo.dart';
import 'package:money_manager/features/verification/logic/cubit/verification_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() async {
  getIt.registerLazySingleton<DatabaseServices>(() => DatabaseServices());

  // Cubits
  getIt.registerFactory<VerificationCubit>(() => VerificationCubit(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerFactory<TransactionCubit>(() => TransactionCubit(getIt()));
  getIt.registerFactory<BankCardCubit>(() => BankCardCubit(getIt()));
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(getIt()));
  getIt.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt()));

  // Repos
  getIt
      .registerLazySingleton<VerificationRepo>(() => VerificationRepo(getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerLazySingleton<TransactionRepo>(() => TransactionRepo(getIt()));
  getIt.registerLazySingleton<BankCardRepo>(() => BankCardRepo(getIt()));
  getIt.registerLazySingleton<TransactionDetailsRepo>(
      () => TransactionDetailsRepo(getIt()));
  getIt.registerLazySingleton<CategoriesRepo>(() => CategoriesRepo(getIt()));
  getIt.registerLazySingleton<ResetPasswordRepo>(
      () => ResetPasswordRepo(getIt()));
}
