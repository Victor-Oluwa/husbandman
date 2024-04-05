// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/onboarding/domain/entities/page__content.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
    required this.pageContent,
    required this.onNext,
    super.key,
  });

  final PageContent pageContent;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(pageContent.image),
          HBMTextWidget(
            // color: HBMColors.slateGray,
            data: pageContent.title,
            fontSize: context.width * 0.05,
            fontFamily: HBMFonts.quicksandBold,
          ),
          SizedBox(height: context.height * 0.04),
          HBMTextWidget(
            // color: HBMColors.slateGray,
            data: pageContent.description,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.height * 0.07),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: HBMColors.slateGray,
              foregroundColor: HBMColors.almond,
            ),
            child: HBMTextWidget(data: pageContent.buttonText),
          ),
        ],
      ),
    );
  }
}
