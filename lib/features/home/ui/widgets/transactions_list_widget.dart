part of 'transactions_container.dart';

class _TransactionsListWidget extends StatelessWidget {
  final TransactionType transactionType;
  const _TransactionsListWidget({required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.state is! HomeTransactionsFiltered) {
      homeCubit.filterTransactionsByType();
    }

    final bool isExpanse = transactionType == TransactionType.expense;
    final String typeSign = isExpanse ? '-' : '+';
    final bool isPeriodicFormat = homeCubit.getDateFormat == 'Periodic';

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final List<Transaction> transactions = state is HomeTransactionsFiltered
            ? isExpanse
                ? state.expenses
                : state.incomes
            : [];

        final int listLength = transactions.length;
        final String transactionType = isExpanse ? 'Expense' : 'Income';

        return listLength == 0
            ? Center(
                child: Text(
                  'There are no $transactionType, \n try saving new $transactionType',
                  style: TextStyles.f14GreySemiBold,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 5.h),
                itemCount: listLength > 5 ? 5 : listLength,
                itemBuilder: (context, index) {
                  final Transaction currentTransaction = transactions[index];
                  final String categoryName = currentTransaction.categoryName;
                  final Category currentTransactionCategory =
                      homeCubit.getTransactionCategory(categoryName);
                  final String title = currentTransaction.title;
                  final DateTime date = currentTransaction.date;
                  final String formattedDate = isPeriodicFormat
                      ? DateHelper.getPeriodicDate(date)
                      : DateHelper.toDateFormat(date.toString())!;
                  final double amount = currentTransaction.amount;
                  final int categoryColorCode =
                      currentTransactionCategory.colorCode;
                  final String createdAt = currentTransaction.createdAt;
                  final String currencyAbbreviation =
                      homeCubit.getCurrencyAbbreviation;

                  return Dismissible(
                    key: Key(currentTransaction.createdAt),
                    onDismissed: (direction) => onDismissed(context, createdAt),
                    background: const DismissibleBackground(),
                    direction: DismissDirection.endToStart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          color: Colors.grey[50],
                          border: Border(
                            left: BorderSide(
                              color: isExpanse
                                  ? AppColors.lightRedColor
                                  : AppColors.lightGreenColor,
                              width: 5.w,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: ListTile(
                          onTap: () {
                            context.pushNamed(Routes.transactionDetailsScreen,
                                arguments: currentTransaction);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          titleAlignment: ListTileTitleAlignment.top,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Hero(
                              tag: '$createdAt+$title',
                              child: DefaultTextStyle(
                                style: TextStyles.f18BlackSemiBold,
                                child: Text(
                                  title,
                                ),
                              ),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Hero(
                              tag: '$createdAt+$formattedDate',
                              child: DefaultTextStyle(
                                style: TextStyles.f15GreySemiBold,
                                child: Text(
                                  formattedDate,
                                ),
                              ),
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Hero(
                                tag: '$createdAt+$amount',
                                child: DefaultTextStyle(
                                  style: isExpanse
                                      ? TextStyles.f18RedSemiBold
                                      : TextStyles.f18LightGreenSemiBold,
                                  child: Text(
                                    '$typeSign$currencyAbbreviation $amount',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Hero(
                                tag: '$createdAt+$categoryColorCode',
                                child: Container(
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: Color(categoryColorCode)
                                        .withOpacity(0.50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3.0,
                                    ),
                                    child: DefaultTextStyle(
                                      style:
                                          TextStyles.f12BlackSemiBold.copyWith(
                                        color: Color(categoryColorCode +
                                                categoryColorCode * 3)
                                            .withOpacity(0.75),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      child: Text(
                                        categoryName,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  onDismissed(BuildContext context, String createdAt) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final BankCardCubit bankCardCubit = context.read<BankCardCubit>();
    homeCubit.deleteTransaction(createdAt);
    bankCardCubit.updateBankCardData();
  }
}
