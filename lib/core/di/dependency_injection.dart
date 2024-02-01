import 'package:get_it/get_it.dart';
import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/features/home/data/repos/home_repo.dart';
import 'package:money_manager/features/home/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/verification/data/repos/verification_repo.dart';
import 'package:money_manager/features/verification/logic/cubit/verification_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() async {
  getIt.registerLazySingleton<DatabaseServices>(() => DatabaseServices());

  getIt.registerFactory<VerificationCubit>(() => VerificationCubit(getIt()));
  getIt.registerFactory<TransactionCubit>(() => TransactionCubit(getIt()));

  getIt
      .registerLazySingleton<VerificationRepo>(() => VerificationRepo(getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
}
