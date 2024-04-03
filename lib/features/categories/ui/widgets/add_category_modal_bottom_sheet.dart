import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';
import 'package:money_manager/core/widgets/app_drop_down_menu_item.dart';
import 'package:money_manager/core/widgets/app_text_form_field.dart';
import 'package:money_manager/features/categories/logic/cubit/categories_cubit.dart';
import 'package:money_manager/features/categories/ui/widgets/categories_error_bloc_listener.dart';

class AddCategoryBottomSheet extends StatelessWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = context.read<CategoriesCubit>();
    final TextEditingController categoryNameController =
        categoriesCubit.categoryNameController;
    final TextEditingController categoryColorController =
        categoriesCubit.categoryColorController;
    final List<int> categoriesColors = categoriesCubit.categoriesColorsValues;
    final List<String> categoriesColorsNames =
        categoriesCubit.categoriesColorsNames;

    categoriesCubit.setupCategoryControllers();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          alignment: AlignmentDirectional.center,
          width: double.infinity,
          height: 60.h,
          child: Text(
            'New Custom Category',
            style: TextStyles.f20WhiteSemiBold.copyWith(
                fontSize: TextStyles.getResponsiveFontSize(context,
                    baseFontSize: 20)),
            textAlign: TextAlign.center,
          ),
        ),
        verticalSpace(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTextFormField(
                title: 'Category Name',
                hintText: 'Entertainment, Food, etc.',
                controller: categoryNameController,
              ),
              verticalSpace(20),
              AppDropDownMenuItem(
                items: categoriesColorsNames,
                title: 'Category Color',
                controller: categoryColorController,
                titleText: categoryColorController.text,
                itemColors: [
                  for (var colorValue in categoriesColors) Color(colorValue)
                ],
              )
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: AppButton(
            onPress: () {
              final bool isSaved = categoriesCubit.saveCategory();
              Navigator.of(context).pop(isSaved);
            },
            text: 'Add Category',
          ),
        ),
        const CategoriesErrorBlocListener(),
      ],
    );
  }
}
