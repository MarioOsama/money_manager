import 'package:hive/hive.dart';
import 'package:money_manager/core/database/database_constants.dart';

class DatabaseServices {
  final _verBox = Hive.box(DatabaseConstants.verBox);
  final _expensesBox = Hive.box(DatabaseConstants.expensesBox);

  bool isVerificationDatabaseInitialized() {
    return _verBox.get(DatabaseConstants.verBox) != null;
  }

  void initializeVerificationDatabaseAndStoreUserPinCode(String pin) {
    _verBox.put(DatabaseConstants.verBox, pin);
  }

  bool isVerifiedUserPinCode(String pinCode) {
    final storedPinCode = _verBox.get(DatabaseConstants.verBox);
    return storedPinCode == pinCode;
  }

  bool isExpensesDatabaseInitialized() {
    return _expensesBox.get(DatabaseConstants.expensesBox) != null;
  }

  // void initializeExpensesDatabase() {
  //   // generate a map of expenses

  //   final expensesData = <String, dynamic>{
  //     DatabaseConstants.expensesBox: true,
  //   };
  //   _expensesBox.put(DatabaseConstants.expensesBox, true);
  // }
}
