import 'package:money_manager/core/database/database_services.dart';

class TransactionDetailsRepo {
  final DatabaseServices _databaseServices;

  TransactionDetailsRepo(this._databaseServices);

  void deleteTransaction(String transactionId) {
    _databaseServices.deleteTransactionFromDatabase(transactionId);
  }
}
