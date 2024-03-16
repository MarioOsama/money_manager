import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/di/dependency_injection.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/categories/logic/cubit/categories_cubit.dart';
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
        return Column(
          children: [
            BlocBuilder<CategoriesCubit, CategoriesState>(
              buildWhen: (previous, current) => current is CategoriesSelected,
              builder: (context, state) {
                bool isCategoriesSelected = false;
                final isCategoriesSelectedState = state is CategoriesSelected;
                if (isCategoriesSelectedState) {
                  isCategoriesSelected =
                      state.listOfSelectedCategories.isNotEmpty;
                } else {
                  isCategoriesSelected = false;
                }

                return CustomAppBar(
                  title: 'Categories',
                  action: IconButton(
                    onPressed: () async {
                      onDeleteCategory(context);
                    },
                    icon: Icon(
                      isCategoriesSelected ? Icons.delete : Icons.add,
                      color: AppColors.primaryDarkColor,
                      size: 27.sp,
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (ctx, index) {
                final Category currentCategory = categories[index];

                return CategoriesListItem(
                    key: ValueKey(currentCategory.id),
                    currentCategory: currentCategory);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showAddCategoriesBottomSheet(BuildContext context) async {
    context.read<CategoriesCubit>().emitCategoriesCreatingState();
    final bool? savingProcessState = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt<CategoriesCubit>(),
          child: const AddCategoryBottomSheet(),
        );
      },
    );
    return savingProcessState;
  }

  void onDeleteCategory(BuildContext context) async {
    final CategoriesCubit categoriesCubit = context.read<CategoriesCubit>();
    final state = categoriesCubit.state;
    bool isCategoriesSelected = false;
    List<String> selectedCategories = [];
    final isCategoriesSelectedState = state is CategoriesSelected;
    if (isCategoriesSelectedState) {
      isCategoriesSelected = state.listOfSelectedCategories.isNotEmpty;
      selectedCategories =
          isCategoriesSelected ? state.listOfSelectedCategories : [];
    } else {
      isCategoriesSelected = false;
    }
    if (!isCategoriesSelected) {
      final bool? isSaved = await showAddCategoriesBottomSheet(context);
      if (isSaved == true) {
        categoriesCubit.loadCategories();
      }
    } else {
      bool isDeleteConfirmed = await showDeleteConfirmationDialog(context);
      if (isDeleteConfirmed) {
        deleteCategory(categoriesCubit, selectedCategories);
        categoriesCubit.loadCategories();
      }
    }
  }

  void deleteCategory(
      CategoriesCubit categoriesCubit, List<String> selectedCategoriesNames) {
    selectedCategoriesNames.forEach(
        (categoryName) => categoriesCubit.deleteCategory(categoryName));
  }

  Future<bool> showDeleteConfirmationDialog(context) async {
    bool isConfirmed = false;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Delete Category'),
            content: const Text(
                'All categories belong to this category will be deleted, Are you sure about deleting this category'),
            actions: [
              TextButton(
                  onPressed: () {
                    isConfirmed = false;
                    ctx.pop();
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    isConfirmed = true;
                    ctx.pop();
                  },
                  child: const Text('Yes')),
            ],
          );
        });
    return isConfirmed;
  }
}