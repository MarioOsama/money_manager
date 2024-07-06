part of 'transactions_container.dart';

class _TransactionsHeaderWidget extends StatelessWidget {
  final TransactionType transactionType;
  const _TransactionsHeaderWidget({required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final String title = transactionType == TransactionType.expense
        ? AppString.expense.tr()
        : AppString.income.tr();

    final String localeLanguageCode = context.locale.languageCode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _getHeaderTitle(
                localeLanguageCode, "${AppString.recent.tr()} $title"),
            style: TextStyles.f16BlackSemiBold.copyWith(
                fontSize: TextStyles.getResponsiveFontSize(context,
                    baseFontSize: 16)),
          ),
          TextButton(
            onPressed: () {
              context.pushNamed(Routes.allTransactionsScreen,
                  arguments: transactionType);
            },
            child: Text(AppString.seeAll.tr(),
                style: TextStyles.f15GreyRegular.copyWith(
                    fontSize: TextStyles.getResponsiveFontSize(context,
                        baseFontSize: 15))),
          ),
        ],
      ),
    );
  }

  String _getHeaderTitle(String languageCode, String title) {
    if (languageCode == 'ar') {
      return title.split(' ').reversed.join(' ');
    } else {
      return title;
    }
  }
}
