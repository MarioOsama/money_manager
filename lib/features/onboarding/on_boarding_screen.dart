import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildImageStack(),
          verticalSpace(20),
          _buildSloganText(),
          verticalSpace(20),
          AppButton(
            onPress: () {},
            text: 'Get Started',
            width: 365,
          ),
        ],
      ),
    );
  }

  Widget _buildSloganText() {
    return const Text(
      "Spend Smarter\nSave More",
      style: TextStyles.f36PrimaryBlack,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildImageStack() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SvgPicture.asset(
          'assets/svgs/on-boarding-bg.svg',
          height: 610.h,
        ),
        Transform.rotate(
          angle: 0.2,
          child: Image.asset(
            'assets/images/on-boarding-fg-main.png',
            scale: 1,
          ),
        ),
      ],
    );
  }
}
