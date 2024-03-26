import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/app_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  //TODO: Add carousel to onboarding screen
  //TODO: Update the splash screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildImageStack(),
          verticalSpace(20),
          _buildSloganText(context),
          verticalSpace(20),
          AppButton(
            onPress: () {
              context.pushNamed(Routes.verificationScreen);
            },
            text: 'Get Started',
            width: 365.w,
          ),
        ],
      ),
    );
  }

  Widget _buildSloganText(context) {
    return SizedBox(
      width: 0.75 * MediaQuery.of(context).size.width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          "Spend Smarter\nSave More",
          style: TextStyles.f36PrimaryMostBold,
          textAlign: TextAlign.center,
        ),
      ),
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
