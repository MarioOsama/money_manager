part of 'bank_card_container.dart';

class _BankCardWidget extends StatelessWidget {
  const _BankCardWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        double totalBalance = state is TransactionFiltered
            ? state.incomesAmount - state.expensesAmount
            : 0.0;
        double income =
            state is TransactionFiltered ? state.incomesAmount : 0.0;
        double expense =
            state is TransactionFiltered ? state.expensesAmount : 0.0;
        return Container(
          height: 205.h,
          width: 375.w,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cyanColor,
                blurRadius: 15,
                offset: Offset(0, 5),
                spreadRadius: 5,
              )
            ],
            image: const DecorationImage(
                image: AssetImage('assets/images/home-card-circles.png'),
                fit: BoxFit.fitWidth),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyles.f18CyanMedium,
                      ),
                      Text('$totalBalance', style: TextStyles.f30WhiteBold),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 30,
                        color: AppColors.cyanColor,
                      ))
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  _buildBalanceCard(
                      title: 'Income',
                      amount: '$income',
                      icon: const Icon(
                        Icons.download_sharp,
                        color: AppColors.cyanColor,
                        size: 20,
                      )),
                  const Spacer(),
                  horizontalSpace(10),
                  _buildBalanceCard(
                      title: 'Expense',
                      amount: '$expense',
                      icon: const Icon(
                        Icons.file_upload,
                        color: AppColors.cyanColor,
                        size: 20,
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _buildBalanceCard(
      {required String title, required String amount, required Icon icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.cyanColor.withOpacity(0.2),
              child: icon,
            ),
            horizontalSpace(7),
            Text(
              title,
              style: TextStyles.f18CyanMedium,
            ),
          ],
        ),
        Text(
          amount,
          style: TextStyles.f18WhiteSemiBold,
        ),
      ],
    );
  }
}
