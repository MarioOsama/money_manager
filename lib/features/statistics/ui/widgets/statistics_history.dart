import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/features/statistics/cubit/statistics_cubit.dart';
import 'package:money_manager/features/statistics/ui/widgets/statistics_history_item.dart';

class StatisticsHistory extends StatelessWidget {
  const StatisticsHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        return Column(
          children: [
            StatisticsHistoryItem(
                title: 'Today',
                amount:
                    (state as StatisticsLoaded).historyAmountData['today'] ??
                        0),
            verticalSpace(20),
            Row(
              children: [
                Expanded(
                    child: StatisticsHistoryItem(
                        title: 'Last Week',
                        amount: (state).historyAmountData['week'] ?? 0)),
                horizontalSpace(20),
                Expanded(
                  child: StatisticsHistoryItem(
                      title: 'Last Month',
                      amount: (state).historyAmountData['month'] ?? 0),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
