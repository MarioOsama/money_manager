import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/dismissible_background.dart';
import 'package:money_manager/features/categories/cubit/categories_cubit.dart';
import 'package:money_manager/features/categories/ui/widgets/add_category_modal_bottom_sheet.dart';
import 'package:money_manager/features/categories/ui/widgets/categories_list_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = context.read<CategoriesCubit>();
    categoriesCubit.loadCategories();

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) => current is CategoriesLoaded,
      builder: (context, state) {
        final List<Category> categories =
            state is CategoriesLoaded ? state.categories : <Category>[];
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyles.f20PrimaryDarkSemiBold,
                    ),
                    IconButton(
                      onPressed: () {
                        showAddCategoriesBottomSheet(context);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.primaryDarkColor,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (ctx, index) {
                  final Category currentCategory = categories[index];

                  return Dismissible(
                    key: ValueKey(currentCategory.name),
                    background: const DismissibleBackground(),
                    direction: DismissDirection.endToStart,
                    child: CategoriesListItem(currentCategory: currentCategory),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showAddCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const AddCategoryBottomSheet();
      },
    );
  }
}
