import 'package:money_manager/core/database/database_services.dart';
import 'package:money_manager/core/models/transaction.dart';

class TransactionRepo {
  final DatabaseServices _databaseServices;

  TransactionRepo(this._databaseServices);

  void saveTransaction(Transaction newTransaction) {
    _databaseServices.saveTransactionToDatabase(newTransaction);
  }

  void updateTransaction(Transaction updatedTransaction) {
    _databaseServices.saveTransactionToDatabase(updatedTransaction);
  }
}
