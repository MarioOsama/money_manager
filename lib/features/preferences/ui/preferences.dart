import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';
import 'package:money_manager/features/preferences/logic/cubit/preferences_cubit.dart';
import 'package:money_manager/features/preferences/ui/widgets/preferences_error_bloc_listener.dart';
import 'package:money_manager/features/preferences/ui/widgets/preferences_item.dart';
import 'package:money_manager/features/preferences/ui/widgets/preferences_toggle_button.dart';

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
    final List<bool> languagesSelection = userPreferences['selectedLanguage']!;
    final List<bool> currenciesSelection = userPreferences['selectedCurrency']!;
    final List<bool> dateFormatSelection =
        userPreferences['selectedDateFormat']!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primaryDarkColor,
        title: Text(
          AppString.preferences.tr(context: context),
          style: TextStyles.f22PrimaryDarkSemiBold.copyWith(
              fontSize:
                  TextStyles.getResponsiveFontSize(context, baseFontSize: 22)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 30.0),
        child: Column(
          children: [
            PreferencesItem(
              title: AppString.language.tr(),
              subtitle: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppString.languageDescription.tr(),
                  style: TextStyles.f14GreyRegular.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 14)),
                ),
              ),
              trailing: PreferencesToggleButton(
                items: preferencesCubit.languages,
                selectedItems: languagesSelection,
              ),
            ),
            verticalSpace(30),
            PreferencesItem(
              title: AppString.dateFormat.tr(),
              subtitle: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppString.dateFormatDescription.tr(),
                  style: TextStyles.f14GreyRegular.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 14)),
                ),
              ),
              trailing: PreferencesToggleButton(
                items: preferencesCubit.dateFormats,
                selectedItems: dateFormatSelection,
              ),
            ),
            verticalSpace(30),
            PreferencesItem(
              title: AppString.currency.tr(),
              subtitle: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppString.currencyDescription.tr(),
                  style: TextStyles.f14GreyRegular.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 14)),
                ),
              ),
              trailing: PreferencesToggleButton(
                items: preferencesCubit.currencies,
                selectedItems: currenciesSelection,
              ),
            ),
            BlocBuilder<PreferencesCubit, PreferencesState>(
              builder: (context, state) {
                final isCustomCurrency = state.currency != '\$';
                return Visibility(
                  visible: isCustomCurrency,
                  child: AppTextFormField(
                    controller: currencyController,
                    title: AppString.currency.tr(),
                    hintText: '€, £, GBP, JPY, etc.',
                    keyboardType: TextInputType.name,
                    maxLength: 3,
                    textStyle: TextStyles.f18PrimarySemiBold.copyWith(
                        fontSize: TextStyles.getResponsiveFontSize(context,
                            baseFontSize: 18)),
                    capitalization: true,
                  ),
                );
              },
            ),
            const Spacer(),
            AppButton(
                onPress: () {
                  preferencesCubit.saveUserPreferences();
                },
                text: AppString.save.tr()),
            const PreferencesErrorBlocListener(),
          ],
        ),
      ),
    );
  }

  // List<String> _getDateFormat(PreferencesCubit preferencesCubit) {
  //   return preferencesCubit.dateFormats
  //       .map(
  //         (title) => Text(title),
  //       )
  //       .toList();
  // }

  // List<String> _getCurrencyAbbreviation(PreferencesCubit preferencesCubit) {
  //   return preferencesCubit.currencies
  //       .map(
  //         (title) => Text(title),
  //       )
  //       .toList();
  // }

  // List<String> _getLanguage(PreferencesCubit preferencesCubit) {
  //   return preferencesCubit.languages
  //       .map(
  //         (title) => Text(title),
  //       )
  //       .toList();
  // }
}
