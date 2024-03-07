import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/categories/cubit/categories_cubit.dart';

class CategoriesListItem extends StatefulWidget {
  final Category currentCategory;
  const CategoriesListItem({super.key, required this.currentCategory});

  @override
  State<CategoriesListItem> createState() => _CategoriesListItemState();
}

class _CategoriesListItemState extends State<CategoriesListItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final CategoriesCubit categoriesCubit = context.read<CategoriesCubit>();
    final int numberOfTransactions =
        categoriesCubit.getCategoryTransactionsCount(widget.currentCategory);
    final double totalAmount =
        categoriesCubit.getCategoryTransactionsAmount(widget.currentCategory);

    final String currentCategoryName = widget.currentCategory.name;

    Widget? checkBoxIcon = isSelected
        ? const Icon(
            Icons.check_box,
            color: AppColors.lightPrimaryColor,
          )
        : const Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey,
          );

    // Check the default category
    final isOtherCategory = currentCategoryName == 'Other';

    if (isOtherCategory) {
      checkBoxIcon = null;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          left: BorderSide(
            color: Color(widget.currentCategory.colorCode),
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        // Category Name
        title: Text(
          currentCategoryName,
          style: TextStyles.f18BlackSemiBold,
        ),
        // Number of Transactions in this category
        subtitle: Text('$numberOfTransactions Transactions',
            style: TextStyles.f14GreySemiBold),
        trailing: Container(
          width: 100.w,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          // Total Amount of Transaction in this category
          child: Text(
            '\$ $totalAmount',
            style: TextStyles.f14WhiteSemiBold,
            textAlign: TextAlign.center,
          ),
        ),
        // Check box icon
        leading: checkBoxIcon,
        // Toggle the check box
        onTap: () {
          if (isOtherCategory) {
            return;
          }
          setState(() {
            isSelected = !isSelected;
          });
          categoriesCubit.toggleCategorySelection(currentCategoryName);
        },
      ),
    );
  }
}
