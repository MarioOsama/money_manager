import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/helpers/spacing.dart';
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
                  state.message,
                  style: TextStyles.f14WhiteSemiBold,
                ),
                backgroundColor: Colors.red,
              ),
            );
        } else if (state is ResetPasswordSuccessflly) {
          context.pop();
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                Future.delayed(const Duration(seconds: 1), () {
                  ctx.pop();
                });
                return SimpleDialog(backgroundColor: Colors.white, children: [
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
                          'Password reset successfully',
                          style: TextStyles.f16PrimaryMedium,
                        ),
                      ],
                    ),
                  ),
                ]);
              });
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
