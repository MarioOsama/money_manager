import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';
import 'package:money_manager/features/preferences/logic/cubit/preferences_cubit.dart';
import 'package:money_manager/features/preferences/widgets/preferences_error_bloc_listener.dart';
import 'package:money_manager/features/preferences/widgets/preferences_item.dart';
import 'package:money_manager/features/preferences/widgets/preferences_toggle_button.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PreferencesCubit preferencesCubit = context.read<PreferencesCubit>();
    preferencesCubit.loadUserPreferences();
    final TextEditingController currencyController =
        preferencesCubit.currencyController;

    final Map<String, List<bool>> userPreferences =
        preferencesCubit.getUserPreferences();
    final List<bool> currenciesSelection = userPreferences['selectedCurrency']!;
    final List<bool> dateFormatSelection =
        userPreferences['selectedDateFormat']!;

    final List<Widget> dateFormatItems =
        preferencesCubit.dateFormats.map((title) => Text(title)).toList();
    final List<Widget> currencyItems =
        preferencesCubit.currencies.map((title) => Text(title)).toList();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primaryDarkColor,
        title: Text(
          'Preferences',
          style: TextStyles.f22PrimaryDarkSemiBold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
        child: Column(
          children: [
            PreferencesItem(
              title: 'Date Format',
              subtitle: Text(
                'Prefered date format.',
                style: TextStyles.f14GreyRegular,
              ),
              trailing: PreferencesToggleButton(
                items: dateFormatItems,
                selectedItems: dateFormatSelection,
              ),
            ),
            verticalSpace(15),
            PreferencesItem(
              title: 'Currency',
              subtitle: Text(
                'Your country currency.',
                style: TextStyles.f14GreyRegular,
              ),
              trailing: PreferencesToggleButton(
                  items: currencyItems, selectedItems: currenciesSelection),
            ),
            BlocBuilder<PreferencesCubit, PreferencesState>(
              builder: (context, state) {
                final isCustomCurrency = state.currency != '\$';
                return AppTextFormField(
                  controller: currencyController,
                  title: isCustomCurrency ? 'Currency' : '',
                  hintText: isCustomCurrency ? '€, £, GBP, JPY, etc.' : '',
                  keyboardType: TextInputType.name,
                  maxLength: 3,
                  textStyle: TextStyles.f18PrimarySemiBold,
                  enabled: currenciesSelection[1],
                  capitalization: isCustomCurrency,
                );
              },
            ),
            const Spacer(),
            AppButton(
                onPress: () {
                  preferencesCubit.saveUserPreferences();
                },
                text: 'Save'),
            const PreferencesErrorBlocListener(),
          ],
        ),
      ),
    );
  }
}
