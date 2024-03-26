import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/features/preferences/logic/cubit/preferences_cubit.dart';

class PreferencesToggleButton extends StatelessWidget {
  final List<Widget> items;
  final List<bool> selectedItems;
  final double? width;
  final double? height;
  const PreferencesToggleButton(
      {super.key,
      required this.items,
      required this.selectedItems,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    final PreferencesCubit preferencesCubit = context.read<PreferencesCubit>();
    final double contextWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, state) {
        return ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          constraints: BoxConstraints(
            minWidth: width ?? contextWidth * 0.22,
            minHeight: height ?? 45.h,
          ),
          onPressed: (int index) {
            final String selectedPreference =
                (items[index] as Text).data.toString();
            preferencesCubit.setUserPreferences(selectedPreference);
            for (int i = 0; i < selectedItems.length; i++) {
              selectedItems[i] = i == index;
            }
          },
          color: AppColors.lightPrimaryColor,
          selectedColor: Colors.white,
          fillColor: AppColors.primaryColor,
          selectedBorderColor: AppColors.primaryDarkColor,
          textStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          isSelected: selectedItems,
          children: items,
        );
      },
    );
  }
}
