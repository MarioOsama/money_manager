import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/verification/logic/cubit/verification_cubit.dart';
import 'package:money_manager/features/verification/logic/cubit/verification_state.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';

part 'numbers_keypad_widget.dart';
part 'verification_bullets_widget.dart';
part 'verification_header_widget.dart';
part 'verification_bloc_listener.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VerificationCubit>().emitUserState();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 90.h, 10.w, 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _VerificationHeader(),
            verticalSpace(80),
            const _VerificationBullets(),
            const Spacer(),
            const _NumbersKeyPad(),
            const _VerificationBlocListener(),
          ],
        ),
      ),
    );
  }
}
