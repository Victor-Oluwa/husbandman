import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:path/path.dart';

class PaymentSuccessfulView extends StatelessWidget {
  const PaymentSuccessfulView({super.key, this.status});
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: context.height * 0.20,
                ),
                SvgPicture.asset(
                  width: context.width * 0.40,
                  MediaRes.successIcon,
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                HBMTextWidget(
                  data: 'Transaction',
                  fontSize: context.width * 0.05,
                ),
                SizedBox(
                  height: context.height * 0.01,
                ),
                HBMTextWidget(
                  data: status??'Successful',
                  fontFamily: HBMFonts.quicksandBold,
                  fontSize: context.width * 0.10,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: context.height * 0.25),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.dashboard,
                        (Route<dynamic> route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                    fixedSize:
                        Size(context.width * 0.70, context.height * 0.05),),
                child: const HBMTextWidget(data:'Dashboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
