import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';

class PreferencesToggleButton extends StatefulWidget {
  final List<Widget> items;
  final List<bool> selectedItems;
  const PreferencesToggleButton(
      {super.key, required this.items, required this.selectedItems});

  @override
  State<PreferencesToggleButton> createState() =>
      _PreferencesToggleButtonState();
}

class _PreferencesToggleButtonState extends State<PreferencesToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(10),
      constraints: const BoxConstraints.expand(
        width: 80,
        height: 45,
      ),
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < widget.selectedItems.length; i++) {
            widget.selectedItems[i] = i == index;
          }
        });
      },
      color: AppColors.lightPrimaryColor,
      selectedColor: Colors.white,
      fillColor: AppColors.primaryColor,
      selectedBorderColor: AppColors.primaryDarkColor,
      textStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
      isSelected: widget.selectedItems,
      children: widget.items,
    );
  }
}
