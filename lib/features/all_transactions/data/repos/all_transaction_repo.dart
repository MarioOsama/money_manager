import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class AllTransactionsRepo {
  final DatabaseServices _databaseServices;
  const AllTransactionsRepo(this._databaseServices);

  List<Transaction> get _getAllTransactions =>
      _databaseServices.getTransactionsFromDatabase();

  List<Transaction> getFilteredTransactions(TransactionType transactionType) {
    return _getAllTransactions
        .where((transaction) => transaction.transactionType == transactionType)
        .toList()
        .reversed
        .toList();
  }

  Category getTransactionCategory(categoryName) {
    return _databaseServices.getCategoryByName(categoryName);
  }

  String getCurrencyAbbreviation() {
    return _databaseServices.getUserPreferences()[DatabaseConstants.currency];
  }

  String getDateFormat() {
    final String dateFormat =
        _databaseServices.getUserPreferences()[DatabaseConstants.dateFormat];
    final String dateFormater =
        dateFormat == 'D days ago' ? 'Periodic' : 'Specific Date';
    return dateFormater;
  }
}
