import 'package:flutter/material.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class TextFieldOne extends StatelessWidget {
  const TextFieldOne({
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.maxLine = 1,
    super.key,
  });

  final String labelText;
  final IconData prefixIcon;
  final int maxLine;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: HBMColors.grey,
      style: TextStyle(fontFamily: HBMFonts.quicksandNormal),
      controller: controller,
      maxLines: maxLine,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: HBMFonts.quicksandNormal,
          fontSize: context.width * 0.03,
          color: HBMColors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HBMColors.mediumGrey, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HBMColors.mediumGrey, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(
          prefixIcon,
          color: HBMColors.mediumGrey,
        ),
      ),
      validator: validator,
    );
  }
}
