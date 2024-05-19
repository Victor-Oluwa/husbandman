import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:husbandman/core/common/app/provider/selected_product_category_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class HBMDropDown extends StatefulWidget {
  HBMDropDown({
    required this.items,
    required this.ref,
    super.key,
  });

  final List<String> items;
  final WidgetRef ref;

  @override
  State<HBMDropDown> createState() => _HBMDropDownState();
}

class _HBMDropDownState extends State<HBMDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: HBMColors.mediumGrey, // Set the border color to grey
          width: 3,
        ),
        borderRadius:
            BorderRadius.circular(15), // Optional: Add rounded corners
      ),
      child: DropdownButton<String>(
        value: widget.ref
            .read(
              selectedProductCategoryProvider.notifier,
            )
            .state,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: HBMColors.grey,
        ),
        // iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: HBMColors.mediumGrey,
          fontFamily: HBMFonts.quicksandNormal,
        ),
        dropdownColor: HBMColors.coolGrey,
        isDense: true,
        onChanged: (String? newValue) {
          setState(() {
            widget.ref.read(selectedProductCategoryProvider.notifier).state =
                newValue ??
                    widget.ref
                        .read(selectedProductCategoryProvider.notifier)
                        .state;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: HBMTextWidget(data:value, fontFamily: HBMFonts.quicksandNormal,),
          );
        }).toList(),
      ),
    );
  }
}
// hel nah
