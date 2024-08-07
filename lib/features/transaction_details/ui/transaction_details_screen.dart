import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/features/transaction_details/data/repos/transaction_details_repo.dart';
import 'package:money_manager/features/transaction_details/ui/widgets/transactions_details.dart';
import 'package:money_manager/features/transaction_details/ui/widgets/type_date_container.dart';
import 'package:money_manager/features/transaction_details/ui/widgets/price_name_container.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionDetailsRepo transactionDetailsRepo;
  final Transaction transaction;
  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
    required this.transactionDetailsRepo,
  });

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.transactionType == TransactionType.expense;
    final transactionTitle = transaction.title;
    final transactionAmount = transaction.amount;
    final transactionDate = transaction.date;
    final transactionCategoryName = transaction.categoryName;
    final transactionNote = transaction.note;
    final transactionAttachmentPath = transaction.attachmentPath;
    final transactionId = transaction.createdAt;

    final transactionCategory =
        transactionDetailsRepo.getTransactionCategory(transactionCategoryName);
    final currencyAbbreviation =
        transactionDetailsRepo.getCurrencyAbbreviation();
    final bool isPeriodicFormat = transactionDetailsRepo.isPeriodic;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppString.transactionDetails.tr()),
        titleTextStyle: TextStyles.f20WhiteSemiBold.copyWith(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 20)),
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.lightPrimaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              deleteTransaction(
                context,
                transactionId,
                transactionDetailsRepo,
              );
            },
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
                        transactionAmount: transactionAmount,
                        transactionId: transactionId,
                        isExpense: isExpense,
                        currencyAbbreviation: currencyAbbreviation,
                      ),
                      TypeDateContainer(
                          isExpense: isExpense,
                          transactionDate: transactionDate,
                          transactionId: transactionId,
                          isPeriodicFormat: isPeriodicFormat),
                    ],
                  ),
                  // Category, note and attachment container
                  TransactionDetails(
                    tarnsactionCategory: transactionCategory,
                    transactionNote: transactionNote,
                    transactionAttachmentPath: transactionAttachmentPath,
                    transactionId: transactionId,
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
              text: AppString.edit.tr(),
            ),
          ),
        ],
      ),
    );
  }

  void deleteTransaction(BuildContext context, String transactionId,
      TransactionDetailsRepo transactionDetailsRepo) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            surfaceTintColor: AppColors.lightPrimaryColor,
            title: Text(AppString.deleteTransaction.tr()),
            content: Text(AppString.deleteTransactionMessage.tr()),
            actions: [
              TextButton(
                onPressed: () {
                  ctx.pop();
                },
                child: Text(
                  AppString.cancel.tr(),
                  style: TextStyles.f14PrimaryBold.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 14)),
                ),
              ),
              TextButton(
                onPressed: () {
                  ctx.pop();
                  transactionDetailsRepo.deleteTransaction(transactionId);
                  context.pushReplacementNamed(Routes.mainScreen);
                },
                child: Text(
                  AppString.delete.tr(),
                  style: TextStyles.f14PrimaryBold.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 14)),
                ),
              ),
            ],
          );
        });
  }
}
