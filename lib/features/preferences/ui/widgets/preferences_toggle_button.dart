import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/features/preferences/logic/cubit/preferences_cubit.dart';

class PreferencesToggleButton extends StatelessWidget {
  final List<Widget> items;
  final List<bool> selectedItems;
  const PreferencesToggleButton(
      {super.key, required this.items, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    final PreferencesCubit preferencesCubit = context.read<PreferencesCubit>();
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, state) {
        return ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          constraints: const BoxConstraints.expand(
            width: 80,
            height: 45,
          ),
          onPressed: (int index) {
            final String selectedPreference = items[index]
                .toStringShallow()
                .split(',')[1]
                .replaceAll('"', '')
                .trim();
            print(selectedPreference);
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
