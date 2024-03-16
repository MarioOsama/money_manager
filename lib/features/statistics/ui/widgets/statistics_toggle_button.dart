import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class StatisticsToggleButton extends StatefulWidget {
  const StatisticsToggleButton({super.key});

  @override
  State<StatisticsToggleButton> createState() => _StatisticsToggleButtonState();
}

class _StatisticsToggleButtonState extends State<StatisticsToggleButton> {
  final selectedItems = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.cyanColor.withOpacity(0.50),
      ),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        fillColor: AppColors.primaryColor,
        selectedColor: Colors.white,
        textStyle: TextStyles.f16WhiteMedium,
        isSelected: selectedItems,
        constraints: BoxConstraints.expand(
          width: 195.w,
          height: 50.h,
        ),
        onPressed: (index) {
          for (int i = 0; i < selectedItems.length; i++) {
            setState(() {
              selectedItems[i] = i == index;
            });
          }
        },
        children: const [
          Text('Expense'),
          Text('Income'),
        ],
      ),
    );
  }
}
