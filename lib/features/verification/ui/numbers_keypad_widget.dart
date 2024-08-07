part of 'verification_screen.dart';

class _NumbersKeyPad extends StatelessWidget {
  const _NumbersKeyPad();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: NumericKeyboard(
        onKeyboardTap: (value) => _onKeypadTap(context, value),
        textStyle: TextStyles.f24CyanBold.copyWith(
            fontSize:
                TextStyles.getResponsiveFontSize(context, baseFontSize: 24)),
        leftIcon: const FittedBox(
          child: Icon(
            Icons.backspace,
            color: AppColors.cyanColor,
          ),
        ),
        leftButtonFn: () => _onBackspaceTap(context),
        rightIcon: FittedBox(
          child: Icon(
            Icons.check,
            color: AppColors.cyanColor,
            size: 30.sp,
          ),
        ),
        rightButtonFn: () => _onDoneTap(context),
      ),
    );
  }

  void _onKeypadTap(BuildContext context, String value) {
    final verificationCubit = context.read<VerificationCubit>();
    String newPinCode = verificationCubit.state.getValue == null
        ? value
        : verificationCubit.state.getValue + value;
    if (newPinCode.length > 4) {
      newPinCode = value;
      verificationCubit.updatePin(newPinCode);
    }
    verificationCubit.updatePin(newPinCode);
  }

  void _onBackspaceTap(BuildContext context) {
    final verificationCubit = context.read<VerificationCubit>();
    final pinCode = verificationCubit.state.getValue;
    if (pinCode.isNotEmpty) {
      final newPinCode = pinCode.substring(0, pinCode.length - 1);
      verificationCubit.updatePin(newPinCode);
    }
  }

  void _onDoneTap(BuildContext context) {
    final verificationCubit = context.read<VerificationCubit>();
    verificationCubit.onDoneTap();
  }
}
