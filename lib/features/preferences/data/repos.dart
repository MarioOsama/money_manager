import 'package:money_manager/core/database/database_services.dart';

class PreferencesRepo {
  final DatabaseServices _databaseServices;

  PreferencesRepo(this._databaseServices);

  void saveUserPreferences(Map<String, dynamic> preferences) {
    _databaseServices.saveUserPreferences(preferences);
  }

  Map<String, dynamic> getUserPreferences() {
    return _databaseServices.getUserPreferences();
  }
}
