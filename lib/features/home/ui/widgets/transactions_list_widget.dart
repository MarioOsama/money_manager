part of 'transactions_container.dart';

class _TransactionsListWidget extends StatelessWidget {
  final TransactionType transactionType;
  const _TransactionsListWidget({required this.transactionType});

  @override
  Widget build(BuildContext context) {
    context.read<TransactionCubit>().filterTransactionsByType(transactionType);

    final bool isExpanse = transactionType == TransactionType.expense;
    final String typeSign = isExpanse ? '-' : '+';
    // TODO: implement periodic formate logic in settings
    final bool isPeriodicFormate = false;

    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        final List<Transaction> transactions = state is TransactionFiltered
            ? isExpanse
                ? state.expenses
                : state.incomes
            : [];

        final int listLength = transactions.length;
        return ListView.builder(
          padding: EdgeInsets.only(top: 5.h),
          itemCount: listLength > 5 ? 5 : listLength,
          itemBuilder: (context, index) {
            final String title = transactions[index].title;
            final DateTime date = transactions[index].date;
            final String formattedDate = isPeriodicFormate
                ? _getPeriodicDate(date)
                : _getFormattedDate(date);
            final double amount = transactions[index].amount;

            return ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              leading: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(transactions[index].imagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(title, style: TextStyles.f18BlackSemiBold),
              subtitle: Text(
                formattedDate,
                style: TextStyles.f15GreyRegular,
              ),
              trailing: Text('$typeSign\$$amount',
                  style: isExpanse
                      ? TextStyles.f18RedSemiBold
                      : TextStyles.f18GreenSemiBold),
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
}
