import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:money_manager/features/reset_password/ui/widgets/password_stage.dart';
import 'package:money_manager/features/reset_password/ui/widgets/reset_password_bloc_listener.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        final resetPasswordCubit = context.read<ResetPasswordCubit>();
        final TextEditingController passwordController =
            resetPasswordCubit.passwordController;

        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: CustomAppBar(
                action: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PasswordStageWidget(
                  stageTitle: state.stageTitle,
                  buttonTitle: state.buttonTitle,
                  passwordController: passwordController,
                  onPressed: () {
                    onPressed(state, resetPasswordCubit);
                  },
                ),
                const ResetPasswordBlocListener(),
              ],
            ),
          ),
        );
      },
    );
  }

  void onPressed(ResetPasswordState state, ResetPasswordCubit cubit) {
    if (state is ResetPasswordInitial) {
      cubit.toNewPasswordState();
    } else if (state is ResetPasswordNewPassword) {
      cubit.toConfirmPasswordState();
    } else if (state is ResetPasswordConfirmPassword) {
      cubit.resetPassword();
    }
  }
}
