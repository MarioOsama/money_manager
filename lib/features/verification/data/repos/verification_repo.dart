import 'package:money_manager/core/database/database_services.dart';

class VerificationRepo {
  final DatabaseServices _databaseServices;

  VerificationRepo(this._databaseServices);

  bool userExistence() {
    return _databaseServices.isVerificationDatabaseInitialized();
  }

  void storeUserPinAndInitData(String pinCode) {
    _databaseServices.initializUserAndData(pinCode);
  }

  bool isVerifiedUserPinCode(String pinCode) {
    return _databaseServices.isVerifiedUserPinCode(pinCode);
  }
}
