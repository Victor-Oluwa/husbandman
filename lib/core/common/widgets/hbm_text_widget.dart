// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HBMTextWidget extends StatelessWidget {
  const HBMTextWidget({
    required this.data,
    super.key,
    this.fontSize,
    this.color,
    this.fontFamily,
    this.fontStyle,
    this.fontWeight,
    this.overflow,
    this.textAlign,
  });
  final String data;
  final double? fontSize;
  final Color? color;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        overflow: overflow,
      ),
      textAlign: textAlign,
    );
  }
}
