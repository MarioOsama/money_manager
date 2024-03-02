import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class AttachmentPickerContainer extends StatelessWidget {
  const AttachmentPickerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        final transactionCubit = context.read<TransactionCubit>();
        final isAttachmentPicked =
            transactionCubit.attachmentPathController.text.isNotEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attachment (Optional)',
              style: TextStyles.f15GreySemiBold,
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
                child: isAttachmentPicked
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
            'Add attachment (Image, PDF, etc.)',
            style: TextStyles.f15GreySemiBold,
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
            'Remove attachment',
            style: TextStyles.f15PrimaryLightSemiBold,
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
