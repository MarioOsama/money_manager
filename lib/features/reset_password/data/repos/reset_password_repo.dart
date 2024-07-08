import 'package:money_manager/core/database/database_services.dart';

class ResetPasswordRepo {
  final DatabaseServices _databaseServices;

  ResetPasswordRepo(this._databaseServices);

  bool checkCurrentPassword(String password) {
    return _databaseServices.checkCurrentPassword(password);
  }

  void resetPassword(String password) {
    _databaseServices.resetPassword(password);
  }
}
