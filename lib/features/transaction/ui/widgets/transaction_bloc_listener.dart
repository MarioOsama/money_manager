import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';

class TransactionBlocListener extends StatelessWidget {
  const TransactionBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionCubit, TransactionState>(
      listenWhen: (previous, current) =>
          previous != current && current is TransactionErrorState ||
          current is TransactionSaved ||
          current is TransactionUpdated,
      listener: (context, state) {
        if (state is TransactionErrorState) {
          final error = state.error;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: AppColors.lightPrimaryColor,
              title: Text(
                AppString.error.tr(),
                style: TextStyles.f20RedBold.copyWith(
                    fontSize: TextStyles.getResponsiveFontSize(context,
                        baseFontSize: 20)),
              ),
              content: Text(
                error,
                style: TextStyles.f16PrimaryMedium.copyWith(
                    fontSize: TextStyles.getResponsiveFontSize(context,
                        baseFontSize: 16)),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    AppString.gotIt.tr(),
                    style: TextStyles.f16LightPrimaryMedium.copyWith(
                        fontSize: TextStyles.getResponsiveFontSize(context,
                            baseFontSize: 16)),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is TransactionSaved) {
          final languageCode = context.locale.languageCode;
          final message = _getSavedMessage(languageCode, state.message);
          context.clearSnackBar();
          context.showSnackBar(
            message: message,
            color: AppColors.lightPrimaryColor,
          );
        }
        if (state is TransactionUpdated) {
          final languageCode = context.locale.languageCode;
          final message = _getUpdatedMessage(languageCode, state.message);
          context.clearSnackBar();
          context.showSnackBar(
            message: message,
            color: AppColors.lightPrimaryColor,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  // Get the saved message based on the language code
  _getSavedMessage(String languageCode, String message) {
    if (languageCode == 'ar') {
      return 'تم حفظ "$message" بنجاح';
    } else if (languageCode == 'en') {
      return '"$message" saved successfully';
    }
  }

  _getUpdatedMessage(String languageCode, String message) {
    if (languageCode == 'ar') {
      return 'تم تحديث "$message" بنجاح';
    } else if (languageCode == 'en') {
      return '"$message" updated successfully';
    }
  }
}
