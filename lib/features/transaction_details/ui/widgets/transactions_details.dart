import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:open_file/open_file.dart';

class TransactionDetails extends StatelessWidget {
  final Category tarnsactionCategory;
  final String? transactionNote;
  final String? transactionAttachmentPath;
  const TransactionDetails(
      {super.key,
      required this.tarnsactionCategory,
      this.transactionNote,
      this.transactionAttachmentPath});

  @override
  Widget build(BuildContext context) {
    final isAttachement = transactionAttachmentPath != null;
    final isPhotoAttachment = isAttachement
        ? transactionAttachmentPath!.contains('.jpg') ||
            transactionAttachmentPath!.contains('.png')
        : false;
    Widget attachmentWidget =
        buildAttachmentWidget(isAttachement, isPhotoAttachment);
    final int categoryColorCode = tarnsactionCategory.colorCode;

    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        margin: EdgeInsets.only(top: 40.h),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 30.0),
              decoration: BoxDecoration(
                color: Color(tarnsactionCategory.colorCode).withOpacity(0.50),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                tarnsactionCategory.name,
                style: TextStyles.f18BlackSemiBold.copyWith(
                  color: Color(categoryColorCode + categoryColorCode * 3)
                      .withOpacity(0.75),
                ),
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
                    style: TextStyles.f20LightGreySemiBold,
                  ),
                  verticalSpace(5),
                  Text(
                    transactionNote ?? 'No Note Added',
                    style: transactionNote == null
                        ? TextStyles.f15GreyRegular
                        : TextStyles.f16BlackRegular,
                  ),
                ],
              ),
            ),
            // Attachment
            verticalSpace(10),
            Text(
              'Attachment',
              style: TextStyles.f20LightGreySemiBold,
            ),
            verticalSpace(10),
            attachmentWidget,
          ],
        ),
      ),
    );
  }

  buildAttachmentWidget(bool isAttachement, bool isPhotoAttachment) {
    Widget toOpenAttachmentWidget = isPhotoAttachment
        ? GestureDetector(
            onTap: () {
              OpenFile.open(
                transactionAttachmentPath!,
              );
            },
            child: Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(
                    File(transactionAttachmentPath!),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.h),
            child: TextButton.icon(
              onPressed: () {
                OpenFile.open(
                  transactionAttachmentPath!,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    isAttachement ? AppColors.lightPrimaryColor : Colors.grey,
              ),
              label: const Text(
                'OpenAttachment',
              ),
              icon: isAttachement
                  ? const Icon(
                      Icons.file_open_outlined,
                    )
                  : null,
            ),
          );

    Widget attachmentWidget = isAttachement
        ? toOpenAttachmentWidget
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0.h),
            child: Text(
              'No Attachment',
              style: TextStyles.f14GreySemiBold,
              textAlign: TextAlign.center,
            ),
          );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: attachmentWidget,
    );
  }
}
