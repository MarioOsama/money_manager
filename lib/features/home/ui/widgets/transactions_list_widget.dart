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
    // TODO: implement periodic formate logic in settings
    final bool isPeriodicFormate = false;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final List<Transaction> transactions = state is HomeTransactionsFiltered
            ? isExpanse
                ? state.expenses
                : state.incomes
            : [];

        final int listLength = transactions.length;
        return ListView.builder(
          padding: EdgeInsets.only(top: 5.h),
          itemCount: listLength > 5 ? 5 : listLength,
          itemBuilder: (context, index) {
            final Transaction currentTransaction = transactions[index];
            final String title = currentTransaction.title;
            final DateTime date = currentTransaction.date;
            final String formattedDate = isPeriodicFormate
                ? _getPeriodicDate(date)
                : _getFormattedDate(date);
            final double amount = currentTransaction.amount;
            final int categoryColorCode = currentTransaction.category.colorCode;

            return Dismissible(
              key: Key(transactions[index].createdAt),
              background: _buildDeleteDismissibleBackground(),
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
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.transactionDetailsScreen,
                          arguments: currentTransaction);
                    },
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      titleAlignment: ListTileTitleAlignment.top,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(title, style: TextStyles.f18BlackSemiBold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          formattedDate,
                          style: TextStyles.f15GreySemiBold,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$typeSign\$$amount',
                              style: isExpanse
                                  ? TextStyles.f18RedSemiBold
                                  : TextStyles.f18LightGreenSemiBold),
                          const Spacer(),
                          Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Color(categoryColorCode).withOpacity(0.25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3.0,
                              ),
                              child: Text(
                                currentTransaction.category.name,
                                textAlign: TextAlign.center,
                                style: TextStyles.f12BlackSemiBold.copyWith(
                                  color: Color(categoryColorCode +
                                          categoryColorCode * 3)
                                      .withOpacity(0.75),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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

  String _getFormattedDate(DateTime date) {
    final String month = date.month.toString();
    final String day = date.day.toString();
    final String year = date.year.toString();
    return '$day, $month, $year';
  }

  String _getPeriodicDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildDeleteDismissibleBackground() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.h),
      padding: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.lightRedColor,
      ),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  //TODO: Delete this method if not used
  Widget _buildEditDismissibleBackground() {
    return Container(
      padding: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.lightPrimaryColor,
      ),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
