import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/widgets/animated_bank_card_container.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';
import 'package:money_manager/features/home/ui/widgets/transactions_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getTransactionsData();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return Center(child: Text(state.error));
        }
        return const Column(
          children: [
            AnimatedBankCardContainer(),
            TransactionsContainer(),
          ],
        );
      },
    );
  }
}
