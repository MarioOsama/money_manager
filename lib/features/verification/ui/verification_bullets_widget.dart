/// This widget represents the verification bullets used in the verification screen.
/// It displays a series of bullets that represent the digits of the verification code.
/// The bullets are initially in dark color and become lighter as the user enters the code digits.
/// The user can also toggle the visibility of the code digits using a show/hide icon.

part of 'verification_screen.dart';

const _visibleBulletsSize = 55.0;
const _invisibleBulletsSize = 25.0;
const _codeContainerRadius = 5.0;
const _codeContainerPadding = 10.0;
const _codeContainerAnimationDuration = Duration(milliseconds: 200);
const _showHideIconSize = 30.0;
const _numberOfBullets = 4;

class _VerificationBullets extends StatefulWidget {
  const _VerificationBullets();

  @override
  State<_VerificationBullets> createState() => _VerificationBulletsState();
}

class _VerificationBulletsState extends State<_VerificationBullets> {
  bool isCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _numberOfBullets; i++)
              BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, state) {
                  final pinCode =
                      context.read<VerificationCubit>().state.getValue ?? '';
                  final codeLength = pinCode.length;
                  return _buildVerificationBullet(
                    isDone: codeLength > i,
                    codeDigit: i < codeLength ? pinCode[i] : '',
                  );
                },
              ),
          ],
        ),
        verticalSpace(25),
        _buildShowHideCodeIcon(),
      ],
    );
  }

  Widget _buildVerificationBullet(
      {required bool isDone, required String codeDigit}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _codeContainerPadding.w),
      child: AnimatedContainer(
        duration: _codeContainerAnimationDuration,
        height: isCodeVisible ? _visibleBulletsSize.h : _invisibleBulletsSize.h,
        width: isCodeVisible ? _visibleBulletsSize.h : _invisibleBulletsSize.h,
        curve: Curves.easeInBack,
        padding: EdgeInsets.fromLTRB(_codeContainerPadding.w, 0,
            _codeContainerPadding.w, _codeContainerPadding.h),
        decoration: BoxDecoration(
          color: isDone
              ? AppColors.cyanColor
              : AppColors.cyanColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(_codeContainerRadius),
        ),
        child: Text(
          isCodeVisible ? codeDigit : '',
          textAlign: TextAlign.center,
          style: TextStyles.f48PrimaryMostBlack,
        ),
      ),
    );
  }

  Widget _buildShowHideCodeIcon() {
    return InkWell(
      onTap: _onVisibilityTap,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      enableFeedback: false,
      child: Icon(
        isCodeVisible ? Icons.visibility : Icons.visibility_off,
        color: AppColors.cyanColor.withOpacity(isCodeVisible ? 1.0 : 0.25),
        size: _showHideIconSize,
      ),
    );
  }

  void _onVisibilityTap() {
    setState(() {
      isCodeVisible = !isCodeVisible;
    });
  }
}
