import 'package:flutter/material.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
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
      ),
      child: TextField(
        style: TextStyle(
          color: const Color(0xff020202),
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        decoration: InputDecoration(
          filled: true,
          // fillColor: const Color(0xfff1f1f1),
          fillColor: HBMColors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          hintText: "Search anything...",
          hintStyle: TextStyle(
            color: const Color(0xffb2b2b2),
            fontSize: context.width*0.04,
            fontFamily: HBMFonts.quicksandNormal,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          prefixIcon: Icon(Icons.search, color: HBMColors.slateGray,),
          prefixIconColor: Colors.black,
        ),
      ),
    );
  }
}