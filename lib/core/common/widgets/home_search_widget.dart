import 'package:flutter/material.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class SearchField extends StatelessWidget {
  const SearchField({required this.isElevated, required this.hintText, super.key});
final bool isElevated;
final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: isElevated? BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(
              0,
              3,
            ), // Adjust the offset as needed
          ),
        ],
      ): const BoxDecoration(),
      child: TextField(
        style: TextStyle(
          color: HBMColors.mediumGrey,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        decoration: InputDecoration(
          filled: true,
          // fillColor: const Color(0xfff1f1f1),
          fillColor: Colors.grey.shade50,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xffb2b2b2),
            fontSize: context.width*0.04,
            fontFamily: HBMFonts.quicksandNormal,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          prefixIcon: Icon(Icons.search, color: HBMColors.charcoalGrey,),
          prefixIconColor: HBMColors.charcoalGrey,
        ),
      ),
    );
  }
}