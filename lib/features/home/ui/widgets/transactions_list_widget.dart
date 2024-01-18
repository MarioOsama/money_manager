part of 'transactions_container.dart';

class _TransactionsListWidget extends StatelessWidget {
  final TransactionType transactionType;
  const _TransactionsListWidget({required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final isExpanse = transactionType == TransactionType.expense;
    final Map<String, Map<String, dynamic>> expensesDummyData = {
      'expense1': {
        'title': 'Groceries',
        'amount': 50.0,
        'date': '2024-01-18',
        'imageUrl':
            'https://images.unsplash.com/photo-1705436195969-5678d64b9720?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'expense2': {
        'title': 'Dinner',
        'amount': 30.0,
        'date': '2024-01-17',
        'imageUrl':
            'https://images.unsplash.com/photo-1705179573286-495f1b4fabaf?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'expense3': {
        'title': 'Gasoline',
        'amount': 40.0,
        'date': '2024-01-16',
        'imageUrl':
            'https://images.unsplash.com/photo-1682687982470-8f1b0e79151a?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'expense4': {
        'title': 'Gasoline',
        'amount': 40.0,
        'date': '2024-01-16',
        'imageUrl':
            'https://images.unsplash.com/photo-1682687982470-8f1b0e79151a?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
    };
    return ListView.builder(
      padding: EdgeInsets.only(top: 5.h),
      itemCount: expensesDummyData.length,
      itemBuilder: (context, index) {
        final String key = expensesDummyData.keys.elementAt(index);
        final Map<String, dynamic> expense = expensesDummyData[key]!;
        return ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          leading: Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(expense['imageUrl']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(expense['title'], style: TextStyles.f18BlackSemiBold),
          subtitle: Text(
            expense['date'],
            style: TextStyles.f15GreyRegular,
          ),
          trailing: Text('-\$${expense['amount']}',
              style: isExpanse
                  ? TextStyles.f18RedSemiBold
                  : TextStyles.f18GreenSemiBold),
        );
      },
    );
  }
}
