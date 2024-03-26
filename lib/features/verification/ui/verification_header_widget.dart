part of 'verification_screen.dart';

class _VerificationHeader extends StatelessWidget {
  const _VerificationHeader();

  @override
  Widget build(BuildContext context) {
    String verificationHeader = 'Type your PIN';

    return Align(
      alignment: Alignment.center,
      child: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
          if (state is VerificationCreatePin) {
            verificationHeader = "Let's setup your PIN";
          } else if (state is VerificationConfirmPin) {
            verificationHeader = 'Confirm your PIN';
          }
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              verificationHeader,
              style: TextStyles.f18WhiteSemiBold,
            ),
          );
        },
      ),
    );
  }
}
