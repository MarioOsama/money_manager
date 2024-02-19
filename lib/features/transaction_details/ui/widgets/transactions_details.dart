import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

class TransactionDetails extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetails({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isAttachement = transaction.attachmentPath != null;
    Widget attachmentWidget = isAttachement
        ? buildAttachmentWidget(isAttachement)
        : buildAttachmentWidget(isAttachement);
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        margin: EdgeInsets.only(top: 40.h),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Shopping',
                style: TextStyles.f18BlackSemiBold,
              ),
            ),
            verticalSpace(10),
            // Note
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note',
                    style: TextStyles.f20GreySemiBold,
                  ),
                  verticalSpace(5),
                  Text(
                    'This is a note This is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a noteThis is a note',
                    style: TextStyles.f16BlackRegular,
                  ),
                ],
              ),
            ),
            // Attachment
            verticalSpace(10),
            Text(
              'Attachment',
              style: TextStyles.f20GreySemiBold,
            ),
            verticalSpace(5),
            attachmentWidget,
          ],
        ),
      ),
    );
  }

  buildAttachmentWidget(bool isAttachement) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isAttachement
              ? TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: isAttachement
                        ? AppColors.lightPrimaryColor
                        : Colors.grey,
                  ),
                  label: const Text(
                    'OpenAttachment',
                  ),
                  icon: isAttachement
                      ? const Icon(
                          Icons.file_open_outlined,
                        )
                      : null,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child:
                      Text('No Attachment', style: TextStyles.f14GreySemiBold),
                ),
        ],
      ),
    );
  }
}
