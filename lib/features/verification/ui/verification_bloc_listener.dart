part of 'verification_screen.dart';

class _VerificationBlocListener extends StatelessWidget {
  const _VerificationBlocListener();

  @override
  Widget build(BuildContext context) {
    final Map<int, Color> errorColorsMap = {
      0: AppColors.redColor,
      1: AppColors.orangeColor,
      2: AppColors.primaryDarkColor,
    };
    return BlocListener<VerificationCubit, VerificationState>(
      listener: (BuildContext context, state) {
        if (state is VerificationErrorState) {
          context.clearSnackBar();
          context.showSnackBar(
              message: state.getValue,
              color: errorColorsMap[state.getErrorCode]);
        } else if (state is VerificationSuccess) {
          context.clearSnackBar();
          context.pushReplacementNamed(Routes.mainScreen);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
