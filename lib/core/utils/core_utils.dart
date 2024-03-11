import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';

class CoreUtils {
  CoreUtils._();

  static void showSnackBar(
      {required String message, required BuildContext context,}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: HBMColors.slateGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(context.width * 0.03),
          content: HBMTextWidget(
            data: message,
          ),
        ),
      );
  }
}
