import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class AttachmentPickerContainer extends StatelessWidget {
  const AttachmentPickerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TransactionCubit, TransactionState, bool?>(
      selector: (state) {
        if (state is TransactionComposing) {
          return state.isAttachmentPicked ?? false;
        } else if (state is TransactionEditing) {
          return state.transaction.attachmentPath.toString().trim().isNotEmpty;
        } else {
          return false;
        }
      },
      builder: (context, isAttachmentPicked) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.attachmentOptional.tr(),
              style: TextStyles.f15GreySemiBold.copyWith(
                  fontSize: TextStyles.getResponsiveFontSize(context,
                      baseFontSize: 15)),
            ),
            verticalSpace(5),
            DottedBorder(
              color: Colors.grey,
              dashPattern: const [8, 4],
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: const Radius.circular(5),
              child: SizedBox(
                height: 65.h,
                width: double.infinity,
                child: isAttachmentPicked!
                    ? _buildAttachmentPreviewButton(context)
                    : _buildAttachmentPickerButton(context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAttachmentPickerButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _onPickAttachment(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_circle,
            color: Colors.grey[600],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            AppString.addAttachment.tr(),
            style: TextStyles.f15GreySemiBold.copyWith(
                fontSize: TextStyles.getResponsiveFontSize(context,
                    baseFontSize: 15)),
          ),
        ],
      ),
    );
  }

  _buildAttachmentPreviewButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _onRemoveAttachment(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.delete,
            color: AppColors.lightPrimaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            AppString.removeAttachment.tr(),
            style: TextStyles.f15PrimaryLightSemiBold.copyWith(
                fontSize: TextStyles.getResponsiveFontSize(context,
                    baseFontSize: 15)),
          ),
        ],
      ),
    );
  }

  void _onPickAttachment(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final transactionCubit = context.read<TransactionCubit>();
      transactionCubit.attachmentPathController.text = file.path;
      transactionCubit.changeAttachmentState();
    }
  }

  void _onRemoveAttachment(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();
    transactionCubit.attachmentPathController.text = '';
    transactionCubit.changeAttachmentState();
  }
}
