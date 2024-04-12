import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/res/color.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.almond,
      body:const SafeArea(
          child: Center(
        child: HBMTextWidget(data: 'ADMIN HOME'),
      ),),
    );
  }
}
