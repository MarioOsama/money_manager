import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class TypeDateContainer extends StatelessWidget {
  const TypeDateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      left: 20,
      right: 20,
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey[500]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Type',
                  style: TextStyles.f16GreySemiBold,
                ),
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 3,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          )),
                    ),
                    horizontalSpace(5),
                    Text(
                      'Expense',
                      style: TextStyles.f18BlackSemiBold,
                    ),
                  ],
                ),
              ],
            ),
            VerticalDivider(
              color: Colors.grey[400],
              thickness: 1,
              width: 1,
              indent: 10,
              endIndent: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Date',
                  style: TextStyles.f16GreySemiBold,
                ),
                Text(
                  '11/12/2021',
                  style: TextStyles.f18BlackSemiBold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
