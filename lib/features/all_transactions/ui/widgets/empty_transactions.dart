import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({super.key, required this.transactionType});

  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            AppString.noTransactions.tr(),
            style: TextStyles.f14GreySemiBold.copyWith(
                fontSize: TextStyles.getResponsiveFontSize(context,
                    baseFontSize: 16)),
            textAlign: TextAlign.center,
          ),
          verticalSpace(24.0),
          ElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.transactionScreen);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
            child: Text(
              AppString.addNewTransaction.tr(),
              style: TextStyles.f16WhiteMedium,
            ),
          ),
        ],
      ),
    );
  }
}
