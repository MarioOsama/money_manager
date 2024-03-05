import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/core/widgets/app_drop_down_menu_item.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';

class AddCategoryBottomSheet extends StatelessWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add Category', style: TextStyles.f20PrimaryDarkSemiBold),
          verticalSpace(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTextFormField(
                title: 'Category Name',
                hintText: 'Entertainment, Food, etc.',
                controller: TextEditingController(),
              ),
              verticalSpace(20),
              AppDropDownMenuItem(
                items: const [
                  1,
                  2,
                  3,
                  4,
                ],
                title: 'Category Color',
                controller: TextEditingController(),
                itemColors: [
                  Color(Colors.green.value),
                  Color(Colors.red.value),
                  Color(Colors.blue.value),
                  Color(Colors.yellow.value),
                ],
              )
            ],
          ),
          const Spacer(),
          AppButton(onPress: () {}, text: 'Save Category')
        ],
      ),
    );
  }
}
