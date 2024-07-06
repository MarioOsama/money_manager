import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/reset_password/logic/cubit/reset_password_cubit.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message.tr(),
                  style: TextStyles.f14WhiteSemiBold.copyWith(
                      fontSize: TextStyles.getResponsiveFontSize(context,
                          baseFontSize: 14)),
                ),
                backgroundColor: Colors.red,
              ),
            );
        } else if (state is ResetPasswordSuccessflly) {
          context.pop();
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                Future.delayed(const Duration(seconds: 2), () {
                  ctx.pop();
                });
                return SimpleDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: AppColors.lightPrimaryColor,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 50,
                          ),
                          verticalSpace(25),
                          Text(
                            AppString.passwordResetedSuccessfully.tr(),
                            style: TextStyles.f16PrimaryMedium.copyWith(
                                fontSize: TextStyles.getResponsiveFontSize(
                                    context,
                                    baseFontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
