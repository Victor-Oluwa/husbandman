import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/route_names.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.almond,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: context.width * 0.25, top: context.height * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HBMTextWidget(
                  data: HBMStrings.accountType,
                  fontSize: context.width * 0.09,
                  fontFamily: HBMFonts.quicksandNormal,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.farmerSignUpScreen);
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        height: context.height * 0.25,
                        child: SvgPicture.asset(MediaRes.farmerGirl),
                      ),
                      HBMTextWidget(data: HBMStrings.seller,
                        fontSize: context.width * 0.07,),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.buyerSignUpScreen);
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        height: context.height * 0.25,
                        child: SvgPicture.asset(MediaRes.femaleBuyer),
                      ),
                      HBMTextWidget(data: HBMStrings.buyer,
                        fontSize: context.width * 0.07,),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
