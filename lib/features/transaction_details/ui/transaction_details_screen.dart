import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                PriceNameContainer(transaction: transaction),
                const TypeDateContainer(),
              ],
            ),
            // Category, note and attachment container
            TransactionDetails(
              transaction: transaction,
            ),
            verticalSpace(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppButton(
                onPress: () {},
                text: 'Edit',
              ),
            )
          ],
        ),
      ),
    );
  }
}
