import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/features/transaction_details/ui/widgets/transactions_details.dart';
import 'package:money_manager/features/transaction_details/ui/widgets/type_date_container.dart';
import 'package:money_manager/features/transaction_details/ui/widgets/price_name_container.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.transactionType == TransactionType.expense;
    final transactionTitle = transaction.title;
    final transactionPrice = transaction.amount;
    final transactionDate = transaction.date;
    final transactionCategory = transaction.category;
    final transactionNote = transaction.note;
    final transactionAttachmentPath = transaction.attachmentPath;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Transaction Details'),
        titleTextStyle: TextStyles.f24whiteSemiBold,
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.lightPrimaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      PriceNameContainer(
                        transactionTitle: transactionTitle,
                        transactionPrice: transactionPrice,
                        isExpense: isExpense,
                      ),
                      TypeDateContainer(
                        isExpense: isExpense,
                        transactionDate: transactionDate,
                      ),
                    ],
                  ),
                  // Category, note and attachment container
                  TransactionDetails(
                    tarnsactionCategory: transactionCategory,
                    transactionNote: transactionNote,
                    transactionAttachmentPath: transactionAttachmentPath,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
            child: AppButton(
              onPress: () {
                context.pushNamed(
                  Routes.transactionScreen,
                  arguments: transaction,
                );
              },
              text: 'Edit',
            ),
          ),
        ],
      ),
    );
  }
}
