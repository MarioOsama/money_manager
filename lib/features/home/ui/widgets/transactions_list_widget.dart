part of 'transactions_container.dart';

class _TransactionsListWidget extends StatelessWidget {
  final TransactionType transactionType;
  const _TransactionsListWidget({required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final bool isExpanse = transactionType == TransactionType.expense;
    final String typeSign = isExpanse ? '-' : '+';
    final Map<String, Map<String, dynamic>> expensesDummyData = {
      'expense1': {
        'title': 'Groceries',
        'amount': 50.0,
        'date': '2024-01-18',
        'imageUrl':
            'https://images.unsplash.com/photo-1590779033100-9f60a05a013d?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'expense2': {
        'title': 'Dinner',
        'amount': 30.0,
        'date': '2024-01-17',
        'imageUrl':
            'https://images.unsplash.com/photo-1603073163308-9654c3fb70b5?q=80&w=1627&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'expense3': {
        'title': 'Gasoline',
        'amount': 40.0,
        'date': '2024-01-16',
        'imageUrl':
            'https://images.unsplash.com/photo-1635627529674-912a0176c6cc?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'expense4': {
        'title': 'Gasoline',
        'amount': 40.0,
        'date': '2024-01-16',
        'imageUrl':
            'https://images.unsplash.com/photo-1635627529674-912a0176c6cc?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
          trailing: Text('$typeSign\$${expense['amount']}',
              style: isExpanse
                  ? TextStyles.f18RedSemiBold
                  : TextStyles.f18GreenSemiBold),
        );
      },
    );
  }
}
