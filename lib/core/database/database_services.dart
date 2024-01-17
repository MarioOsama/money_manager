import 'package:hive/hive.dart';
import 'package:money_manager/core/database/database_constants.dart';

class DatabaseServices {
  final _box = Hive.box(DatabaseConstants.boxName);

  bool isDatabaseInitialized() {
    return _box.get(DatabaseConstants.boxName) != null;
  }
}
