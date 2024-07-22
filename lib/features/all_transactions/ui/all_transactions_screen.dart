import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/all_transactions/logic/cubit/all_transactions_cubit.dart';
import 'package:money_manager/features/all_transactions/ui/widgets/all_transactions_bloc_builder.dart';

class AllTransactionsScreen extends StatelessWidget {
  final TransactionType transactionType;
  const AllTransactionsScreen({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final AllTransactionsCubit allTransactionsCubit =
        context.read<AllTransactionsCubit>();
    allTransactionsCubit.loadAllTransactions(transactionType);
    final String titleType = transactionType == TransactionType.expense
        ? AppString.expense.tr()
        : AppString.income.tr();

    final String languageCode = context.locale.languageCode;

    return Scaffold(
      appBar: CustomAppBar(
        title: _getHeaderTitle(languageCode, titleType),
        withBackButton: true,
        foregroundColor: AppColors.primaryDarkColor,
        action: _buildSortingButton(context, allTransactionsCubit),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AllTransactionsBlocBuilder(),
      ),
    );
  }

  Widget _buildSortingButton(
      BuildContext context, AllTransactionsCubit allTransactionsCubit) {
    final bool isNoTransactions =
        allTransactionsCubit.state is AllTransactionsEmptyState;
    return isNoTransactions
        ? const SizedBox.shrink()
        : IconButton(
            onPressed: () {
              _showSortingModalSheet(context, allTransactionsCubit);
            },
            icon: const Icon(
              Icons.sort,
              color: AppColors.primaryDarkColor,
            ),
          );
  }

  Future<dynamic> _showSortingModalSheet(
      BuildContext context, AllTransactionsCubit allTransactionsCubit) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Lowest Price');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      AppString.lowToHigh.tr(),
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Highest Price');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      AppString.highToLow.tr(),
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Newest Date');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      AppString.newToOld.tr(),
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('Oldest Date');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      AppString.oldToNew.tr(),
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      allTransactionsCubit.sortTransactions('By Category');
                      ctx.pop();
                    },
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    child: Text(
                      AppString.byCategory.tr(),
                      style: TextStyles.f16PrimaryDarkBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _getHeaderTitle(String languageCode, String titleType) {
    if (languageCode == 'ar') {
      return 'كل $titleType';
    } else {
      return '$titleType Transactions';
    }
  }
}
