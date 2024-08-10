import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BreadTextField extends StatelessWidget {
  const BreadTextField({
    required this.fieldController,
    super.key,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.labelText,
    this.helperText,
    this.errorText,
    this.keyboardType = TextInputType.url,
    this.onSubmitted,
    this.onChanged,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.filled,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.prefixStyle,
    this.suffixStyle,
    this.counterStyle,
    this.contentPadding,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth = 2.0,
    this.textStyle,
    this.inputFormatters,
    this.validator, this.floatingLabelBehavior,
  });

  final TextEditingController fieldController;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final String? hintText;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final bool? filled;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final TextStyle? counterStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Color? cursorColor;
  final double? cursorHeight;
  final double cursorWidth;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: fieldController,
      keyboardType: keyboardType,
      enableInteractiveSelection: enableInteractiveSelection,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      cursorWidth: cursorWidth,
      style: textStyle,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefix: prefix,
        suffix: suffix,
        labelText: labelText,
        helperText: helperText,
        errorText: errorText,
        border: border,
        icon: icon,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        disabledBorder: disabledBorder,
        focusedErrorBorder: focusedErrorBorder,
        fillColor: fillColor,
        filled: filled,
        hintStyle: hintStyle,
        labelStyle: labelStyle,
        helperStyle: helperStyle,
        errorStyle: errorStyle,
        prefixStyle: prefixStyle,
        suffixStyle: suffixStyle,
        counterStyle: counterStyle,
        contentPadding: contentPadding,
        floatingLabelBehavior: floatingLabelBehavior,
      ),
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      validator: validator,

    );
  }
}
