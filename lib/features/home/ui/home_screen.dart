import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/widgets/bank_card_widget.dart';
import 'package:money_manager/features/home/logic/cubit/home_cubit.dart';
import 'package:money_manager/features/home/ui/widgets/transactions_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getTransactionsData();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        log('HomeScreen building...');
        log(state.toString());
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return Center(child: Text(state.error));
        } else if (state is HomeLoaded || state is HomeTransactionsFiltered) {
          return const Column(
            children: [
              Expanded(child: BankCardWidget()),
              Expanded(flex: 2, child: TransactionsContainer()),
            ],
          );
        }
        return Container();
      },
    );
  }
}
