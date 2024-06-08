import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/route_names.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              size: context.width * 0.07,
            ),
            SizedBox(
              width: context.width * 0.01,
            ),
            HBMTextWidget(
              data: 'Dashboard',
              color: HBMColors.charcoalGrey,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.04,
                  vertical: context.height * 0.01,
                ),
                child: HBMTextWidget(
                  data: 'Earnings',
                  fontSize: context.width * 0.05,
                  color: HBMColors.charcoalGrey,
                  fontFamily: HBMFonts.exo2,
                ),
              ),
              EarningsCard(),
              SizedBox(
                height: context.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.04,
                  vertical: context.height * 0.01,
                ),
                child: HBMTextWidget(
                  data: 'Wallet Balance',
                  fontSize: context.width * 0.05,
                  color: HBMColors.charcoalGrey,
                  fontFamily: HBMFonts.exo2,
                ),
              ),
              EarningsCard(),
              SizedBox(
                height: context.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.04,
                  vertical: context.height * 0.01,
                ),
                child: HBMTextWidget(
                  data: 'Manage Products',
                  fontSize: context.width * 0.05,
                  color: HBMColors.charcoalGrey,
                  fontFamily: HBMFonts.exo2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.sellerProducts);
                },
                child: SizedBox(
                  height: context.height * 0.22,
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: context.width * 0.04,
                    ),
                    shape: ContinuousRectangleBorder(
                      // side: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(context.width * 0.05),
                    ),
                    color: HBMColors.charcoalGrey,
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HBMTextWidget(
                                data: '251',
                                color: HBMColors.mediumGrey,
                                fontSize: context.width * 0.07,
                                fontFamily: HBMFonts.quicksandBold,
                              ),
                              HBMTextWidget(
                                data: 'Out of stock: 12',
                                color: HBMColors.mediumGrey,
                              ),
                              HBMTextWidget(
                                data: 'Unlisted: 2',
                                color: HBMColors.mediumGrey,
                              ),
                            ],
                          ),
                          Image.asset(MediaRes.manageProduct),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EarningsCard extends StatelessWidget {
  const EarningsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.22,
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: context.width * 0.04,
        ),
        shape: ContinuousRectangleBorder(
          // side: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(context.width * 0.05),
        ),
        color: HBMColors.charcoalGrey,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: HBMColors.mediumGrey,
                            borderRadius: BorderRadius.circular(10)),
                        height: context.height * 0.05,
                        width: context.width * 0.10,
                        child: HBMTextWidget(
                          data: '₦',
                          fontSize: context.width * 0.06,
                          fontFamily: HBMFonts.exo2,
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.02,
                      ),
                      HBMTextWidget(
                        data: '₦33343',
                        fontSize: context.width * 0.04,
                        fontFamily: HBMFonts.quicksandBold,
                        color: HBMColors.mediumGrey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  HBMTextWidget(
                    data: 'Sales',
                    fontFamily: HBMFonts.quicksandBold,
                    color: HBMColors.mediumGrey,
                  ),
                  HBMTextWidget(
                    data: '20',
                    color: HBMColors.mediumGrey,
                  ),
                ],
              ),
              Image.asset(
                MediaRes.earningsChat,
                width: context.width * 0.35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
