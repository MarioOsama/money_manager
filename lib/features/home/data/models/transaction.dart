import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'transaction.g.dart';

const _uuid = Uuid();

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final Category? category;
  @HiveField(5)
  final int? iconCode;
  @HiveField(6)
  final String? imagePath;
  @HiveField(7)
  final TransactionType? transactionType;

  Transaction({
    required this.title,
    required this.amount,
    required this.iconCode,
    required this.date,
    this.category,
    this.imagePath,
    this.transactionType,
  }) : id = _uuid.v4();

  Transaction copyWith({
    String? title,
    double? amount,
    int? iconCode,
    DateTime? date,
    Category? category,
    String? imagePath,
    TransactionType? transactionType,
  }) {
    return Transaction(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      iconCode: iconCode ?? this.iconCode,
      date: date ?? this.date,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      transactionType: transactionType ?? this.transactionType,
    );
  }
}

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int colorCode;

  Category({required this.name, required this.colorCode}) : id = _uuid.v4();

  String get categoryName => name;

  int get categoryColor => colorCode;

  Category copyWith({String? name, int? colorCode}) {
    return Category(
      name: name ?? this.name,
      colorCode: colorCode ?? this.colorCode,
    );
  }
}

@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
}
