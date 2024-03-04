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
}
