import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/features/categories/cubit/categories_cubit.dart';
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
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (ctx, index) {
              final Category currentCategory = categories[index];

              return Dismissible(
                key: ValueKey(currentCategory.name),
                background: _buildDeleteDismissibleBackground(),
                direction: DismissDirection.endToStart,
                child: CategoriesListItem(currentCategory: currentCategory),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDeleteDismissibleBackground() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.lightRedColor,
      ),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
