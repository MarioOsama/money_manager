import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:open_file/open_file.dart';

class TransactionDetails extends StatelessWidget {
  final Category tarnsactionCategory;
  final String transactionId;
  final String? transactionNote;
  final String? transactionAttachmentPath;
  const TransactionDetails({
    super.key,
    required this.tarnsactionCategory,
    this.transactionNote,
    this.transactionAttachmentPath,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final isAttachement = transactionAttachmentPath != null &&
        transactionAttachmentPath!.isNotEmpty;
    final isPhotoAttachment = isAttachement
        ? transactionAttachmentPath!.contains('.jpg') ||
            transactionAttachmentPath!.contains('.png')
        : false;
    Widget attachmentWidget =
        buildAttachmentWidget(context, isAttachement, isPhotoAttachment);
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
            Hero(
              tag: '$transactionId+$categoryColorCode',
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: Color(tarnsactionCategory.colorCode).withOpacity(0.50),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DefaultTextStyle(
                  style: TextStyles.f16BlackSemiBold.copyWith(
                    color: Color(categoryColorCode + categoryColorCode * 3),
                    fontSize: TextStyles.getResponsiveFontSize(context,
                        baseFontSize: 14),
                  ),
                  child: Text(
                    tarnsactionCategory.name,
                  ),
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
                    AppString.note.tr(),
                    style: TextStyles.f20LightGreySemiBold.copyWith(
                        fontSize: TextStyles.getResponsiveFontSize(context,
                            baseFontSize: 20)),
                  ),
                  verticalSpace(5),
                  getNoteWidget(context),
                ],
              ),
            ),
            // Attachment
            verticalSpace(10),
            Text(
              AppString.attachment.tr(),
              style: TextStyles.f20LightGreySemiBold.copyWith(
                  fontSize: TextStyles.getResponsiveFontSize(context,
                      baseFontSize: 20)),
            ),
            verticalSpace(10),
            attachmentWidget,
          ],
        ),
      ),
    );
  }

  buildAttachmentWidget(
      BuildContext context, bool isAttachement, bool isPhotoAttachment) {
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
              label: Text(
                AppString.openAttachment.tr(),
              ),
              icon: const Icon(
                Icons.file_open_outlined,
              ),
            ),
          );

    Widget attachmentWidget = isAttachement
        ? toOpenAttachmentWidget
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0.h),
            child: Text(
              AppString.noAttachment.tr(),
              style: TextStyles.f14GreySemiBold.copyWith(
                  fontSize: TextStyles.getResponsiveFontSize(context,
                      baseFontSize: 14)),
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

  Widget getNoteWidget(BuildContext context) {
    if (transactionNote != null && transactionNote!.trim().isNotEmpty) {
      return Text(
        transactionNote!,
        style: TextStyles.f16BlackMedium.copyWith(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 16)),
      );
    } else {
      return Text(
        AppString.noNote.tr(),
        style: TextStyles.f15GreyRegular.copyWith(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 15)),
      );
    }
  }
}
