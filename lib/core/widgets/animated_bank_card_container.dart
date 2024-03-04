import 'package:flutter/material.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/widgets/bank_card_widget.dart';

class AnimatedBankCardContainer extends StatelessWidget {
  final EdgeInsets? padding;
  const AnimatedBankCardContainer({super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      alignment: Alignment.center,
      padding: padding ?? const EdgeInsets.fromLTRB(12, 50, 12, 12),
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     AppColors.cyanColor,
          //     Colors.white,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          ),
      child: const BankCardWidget(),
    );
  }
}
