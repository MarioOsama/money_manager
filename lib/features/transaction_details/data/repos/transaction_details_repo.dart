import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class TransactionDetailsRepo {
  final DatabaseServices _databaseServices;

  TransactionDetailsRepo(this._databaseServices);

  void deleteTransaction(String transactionId) {
    _databaseServices.deleteTransactionFromDatabase(transactionId);
  }

  Category getTransactionCategory(String categoryName) {
    return _databaseServices.getCategoryByName(categoryName);
  }

  String getCurrencyAbbreviation() {
    return _databaseServices.getUserPreferences()[DatabaseConstants.currency];
  }

  bool get isPeriodic {
    final String dateFormat =
        _databaseServices.getUserPreferences()[DatabaseConstants.dateFormat];
    final String dateFormater =
        dateFormat == 'D days ago' ? 'Periodic' : 'Specific Date';
    return dateFormater == 'Periodic';
  }
}
