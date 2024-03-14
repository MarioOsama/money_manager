import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';
import 'package:money_manager/features/preferences/widgets/preferences_item.dart';
import 'package:money_manager/features/preferences/widgets/preferences_toggle_button.dart';

const List<Widget> dateFormats = <Widget>[
  Text('DD/MM/YYYY'),
  Text('D days ago'),
];

const List<Widget> currencies = <Widget>[
  Text('\$'),
  Text('Custom'),
];

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedDateFormates = <bool>[true, false];
    final List<bool> selectedCurrencies = <bool>[true, false];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
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
                items: dateFormats,
                selectedItems: selectedDateFormates,
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
                  items: currencies, selectedItems: selectedCurrencies),
            ),
            AppTextFormField(
              controller: TextEditingController(),
              keyboardType: TextInputType.name,
              maxLength: 3,
              textStyle: TextStyles.f18PrimarySemiBold,
              enabled: selectedCurrencies[1],
              capitalization: true,
            ),
            const Spacer(),
            AppButton(onPress: () {}, text: 'Save')
          ],
        ),
      ),
    );
  }
}
