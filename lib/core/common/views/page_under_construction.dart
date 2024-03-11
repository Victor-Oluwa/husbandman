import 'package:flutter/material.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.almond,
      body: Center(
        child: Lottie.asset(MediaRes.pageUnderConstruction),
      ),
    );
  }
}
