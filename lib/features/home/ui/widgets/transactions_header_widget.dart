part of 'transactions_container.dart';

class _TransactionsHeaderWidget extends StatelessWidget {
  final TransactionType transactionType;
  const _TransactionsHeaderWidget({required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final String title =
        transactionType == TransactionType.expense ? 'Expenses' : 'Income';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent $title',
          style: TextStyles.f18BlackSemiBold,
        ),
        Text(
          'See all',
          style: TextStyles.f15GreyRegular,
        ),
      ],
    );
  }
}
