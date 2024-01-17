part of 'verification_screen.dart';

class _VerificationBlocListener extends StatelessWidget {
  const _VerificationBlocListener();

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit, VerificationState>(
      listener: (BuildContext context, state) {
        if (state is VerificationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primaryDarkColor,
              content: Text(state.getValue, style: TextStyles.f18WhiteSemiBold),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
