import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class PopUpTextField {
  static void show({
    required BuildContext context,
    required WidgetRef ref,
    required String cartItemId,
    required TextEditingController fieldController,
    required void Function() onNext,
  }) {
    showDialog<AlertDialog>(
      context: context,
      builder: (_) {
        final owner = ref.watch(userProvider);
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                // top: context.height*0.23,
                // bottom: context.height * 0.27,
                ),
            child: AlertDialog(
              title: Center(
                child: HBMTextWidget(
                  data: 'Name Your Order',
                  fontSize: context.width * 0.06,
                ),
              ),
              content: BreadTextField(
                fieldController: fieldController,
                cursorColor: HBMColors.charcoalGrey,
                hintText: 'e.g: Christmas shopping',
                textStyle: TextStyle(
                  color: HBMColors.mediumGrey,
                  fontFamily: HBMFonts.quicksandNormal,
                ),
                hintStyle: TextStyle(
                  color: HBMColors.grey,
                  fontFamily: HBMFonts.quicksandNormal,
                ),
              ),
              backgroundColor: HBMColors.coolGrey,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const HBMTextWidget(data: 'Cancel'),
                ),
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HBMColors.mediumGrey,
                  ),
                  child: HBMTextWidget(
                    data: 'Next',
                    color: HBMColors.coolGrey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
