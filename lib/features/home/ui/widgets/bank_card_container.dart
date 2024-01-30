import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/home/logic/cubit/transaction_cubit.dart';

part 'bank_card_widget.dart';

class BankCardContainer extends StatelessWidget {
  const BankCardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cyanColor.withOpacity(1),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const _BankCardWidget(),
    );
  }
}
