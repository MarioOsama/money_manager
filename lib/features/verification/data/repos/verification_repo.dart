import 'package:money_manager/core/database/database_services.dart';

class VerificationRepo {
  final DatabaseServices _databaseServices;

  VerificationRepo(this._databaseServices);

  bool userExistence() {
    return _databaseServices.isDatabaseInitialized();
  }
}
