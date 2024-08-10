import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class BreadDrawer extends StatelessWidget {
  const BreadDrawer({
    required this.pageBody,
    required this.advancedDrawerController,
    super.key,
    this.tileOneName,
    this.tileOneCallback,
    this.tileTwoName,
    this.tileTwoCallback,
    this.tileThreeName,
    this.tileThreeCallback,
    this.tileFourName,
    this.tileFourCallback,
    this.tileFiveName,
    this.tileFiveCallback,
    this.tileSixName,
    this.tileSixCallback,
  });

  final AdvancedDrawerController advancedDrawerController;
  final Widget pageBody;
  final String? tileOneName;
  final VoidCallback? tileOneCallback;
  final String? tileTwoName;
  final VoidCallback? tileTwoCallback;
  final String? tileThreeName;
  final VoidCallback? tileThreeCallback;
  final String? tileFourName;
  final VoidCallback? tileFourCallback;
  final String? tileFiveName;
  final VoidCallback? tileFiveCallback;
  final String? tileSixName;
  final VoidCallback? tileSixCallback;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: HBMColors.charcoalGrey),
      ),
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 0.0),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: buildDrawer(context),
      child: pageBody,
    );
  }

  SafeArea buildDrawer(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ListTileTheme(
          textColor: HBMColors.mediumGrey,
          tileColor: HBMColors.mediumGrey,
          iconColor: HBMColors.coolGrey,
          horizontalTitleGap: context.width * 0.10,
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.width * 0.08,
              vertical: context.height * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (tileOneName != null)
                ListTile(
                  onTap: tileOneCallback,
                  leading: Icon(Icons.home_filled, size: context.width * 0.08),
                  title: HBMTextWidget(
                    data: tileOneName ?? 'Unknown',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
                  ),
                )
              else
                ColoredBox(child: const SizedBox.shrink(), color: Colors.blue,),
              if (tileTwoName != null)
                ListTile(
                  onTap: tileTwoCallback,
                  leading: Icon(Icons.dashboard, size: context.width * 0.08),
                  title: HBMTextWidget(
                    data: tileTwoName ?? 'Unknown',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
                  ),
                )
              else
                const SizedBox.shrink(),
              if (tileThreeName != null)
                ListTile(
                  onTap: tileThreeCallback,
                  leading: Icon(Icons.person_2, size: context.width * 0.08),
                  title: HBMTextWidget(
                    data: tileThreeName ?? 'Unknown',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
                  ),
                )
              else
                const SizedBox.shrink(),
              if (tileFourName != null)
                ListTile(
                  onTap: tileFourCallback,
                  leading: Icon(Icons.people_alt_rounded,
                      size: context.width * 0.08),
                  title: HBMTextWidget(
                    data: tileFourName ?? 'Unknown',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
                  ),
                )
              else
                const SizedBox.shrink(),
              if (tileFiveName != null)
                ListTile(
                  onTap: tileFiveCallback,
                  leading: Icon(Icons.history, size: context.width * 0.08),
                  title: HBMTextWidget(
                    data: tileFiveName ?? 'Unknown',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
                  ),
                )
              else
                const SizedBox.shrink(),
              if (tileSixName != null)
                ListTile(
                  onTap: tileSixCallback,
                  leading: Icon(Icons.settings, size: context.width * 0.08),
                  title: HBMTextWidget(
                    data: tileSixName ?? 'Unknown',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
                  ),
                )
              else
                const SizedBox.shrink(),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 12, color: Colors.white54),
                child: Container(
                  child: HBMTextWidget(
                    data: 'Terms of Service | Privacy Policy',
                    fontFamily: HBMFonts.quicksandNormal,
                    color: HBMColors.coolGrey,
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
