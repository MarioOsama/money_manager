import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'transaction.g.dart';

const _uuid = Uuid();

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  String createdAt;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String categoryName;
  @HiveField(5)
  final TransactionType transactionType;
  @HiveField(6)
  final String? note;
  @HiveField(7)
  final String? attachmentPath;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryName,
    required this.transactionType,
    this.note,
    this.attachmentPath,
  }) : createdAt = DateTime.now().toUtc().toString();

  Transaction copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    String? categoryName,
    TransactionType? transactionType,
    String? note,
    String? attachmentPath,
  }) {
    return Transaction(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      categoryName: categoryName ?? this.categoryName,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      note: note ?? this.note,
      transactionType: transactionType ?? this.transactionType,
    )..createdAt = id ?? this.createdAt;
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
  @HiveField(3)
  double totalAmount;

  Category(
      {required this.name, required this.colorCode, required this.totalAmount})
      : id = _uuid.v4();

  Category copyWith({String? name, int? colorCode, double? totalAmount}) {
    return Category(
      name: name ?? this.name,
      colorCode: colorCode ?? this.colorCode,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  void updateAmount(double value) {
    this.totalAmount = totalAmount + value;
  }

  @override
  String toString() {
    return name;
  }
}

@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income;

  @override
  String toString() {
    return this == TransactionType.expense ? 'Expense' : 'Income';
  }
}
