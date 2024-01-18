import 'package:flutter/material.dart';
import 'package:money_manager/core/widgets/app_bottom_nav_bar.dart';
import 'package:money_manager/features/home/ui/widgets/bank_card_container.dart';
import 'package:money_manager/features/home/ui/widgets/transactions_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          BankCardContainer(),
          Expanded(
            child: TransactionsContainer(),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
