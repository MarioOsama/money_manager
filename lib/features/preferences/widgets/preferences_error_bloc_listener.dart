import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/features/preferences/logic/cubit/preferences_cubit.dart';

class PreferencesErrorBlocListener extends StatelessWidget {
  const PreferencesErrorBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferencesCubit, PreferencesState>(
      listener: (context, state) {
        if (state is PreferencesErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.redColor,
            ),
          );
        }
        if (state is PreferencesSavedState) {
          context.pop();
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
