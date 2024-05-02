import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/auth/domain/entity/home_category_content.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.content,
    required this.color,
    required this.leftPadding, required this.onTap, super.key,
  });

  final HomeCategoryContent content;
  final Color color;
  final VoidCallback onTap;
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    final categoryListPadding = context.width * 0.05;

    return Padding(
      padding: EdgeInsets.only(
        right: categoryListPadding,
        left: leftPadding,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            width: context.width * 0.13,
            height: context.width * 0.14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // Adjust the color and opacity as needed
                  spreadRadius: 2,
                  // Adjust the spread radius as needed
                  blurRadius: 15,
                  // Adjust the blur radius as needed
                  offset: const Offset(
                    0,
                    3,
                  ), // Adjust the offset as needed
                ),
              ],
            ),
          ),
          HBMTextWidget(
            data: content.name,
            fontFamily: HBMFonts.quicksandBold,
            color: HBMColors.charcoalGrey,
            fontSize: context.width*0.03,
          )
        ],
      ),
    );
  }
}
