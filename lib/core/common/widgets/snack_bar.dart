import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';

class HBMSnackBar {
 static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show({
    required BuildContext context,
    required String content,
  }) {

    final snackBar = SnackBar(
      content: HBMTextWidget(data: content),
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
