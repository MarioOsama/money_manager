import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(name: 'Category 1', colorCode: const Color(0xFFE1E6C3).value),
      Category(name: 'Category 2', colorCode: const Color(0xFFC3E6C8).value),
      Category(name: 'Category 3', colorCode: const Color(0xFFC3C7E6).value),
      Category(name: 'Category 4', colorCode: const Color(0xFFDFC3E6).value),
      Category(name: 'Category 5', colorCode: const Color(0xFFE6C3C3).value),
    ];

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
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  left: BorderSide(
                    color: Color(categories[index].colorCode),
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
                  currentCategory.name,
                  style: TextStyles.f18BlackSemiBold,
                ),
                // Number of Transactions in this category
                subtitle:
                    Text('5 Transactions', style: TextStyles.f14GreySemiBold),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // Total Amount of Transaction in this category
                  child: Text('\$ 4500', style: TextStyles.f14WhiteSemiBold),
                ),
              ),
            ),
          );
        },
      ),
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
