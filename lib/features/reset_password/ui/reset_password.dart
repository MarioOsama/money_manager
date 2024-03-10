import 'package:flutter/material.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/widgets/custom_app_bar.dart';
import 'package:money_manager/features/reset_password/ui/widgets/password_stage.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Map to hold the different screen satges text
    final Map<String, List<String>> screenStagesText = {
      'Current Password Stage': ['Enter your current PIN', 'Next'],
      'New Password Stage': ['Enter your new PIN', 'Confirm'],
      'Confirm password Stage': ['Re-enter new PIN', 'Done']
    };

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: CustomAppBar(
            action: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: PasswordStageWidget(
          stageTitle: screenStagesText['Current Password Stage']![0],
          buttonTitle: screenStagesText['Current Password Stage']![1],
        ),
      ),
    );
  }
}
