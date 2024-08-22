import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/selected_product_category_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

/// A custom dropdown widget with specific styling and state management.
///
/// The [HBMDropDown] widget uses Riverpod for state management to control
/// the selected product category. It is styled with specific colors and fonts
/// defined in the application resources.

class HBMDropDown extends StatelessWidget {
  /// Creates a [HBMDropDown] widget.
  ///
  /// The [items] parameter must not be null and provides the list of dropdown items.
  /// The [ref] parameter is used to read and modify the state of the selected item.

  const HBMDropDown({
    required this.items,
    required this.onChanged,
    required this.value,
    super.key,
  });

  /// The list of items to display in the dropdown.
  final List<String> items;

  /// The reference to the Riverpod provider for managing state.

  final void Function(String?)? onChanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // Make the container take full width of its parent
      padding: const EdgeInsets.all(8),
      // Add padding around the container
      decoration: BoxDecoration(
        border: Border.all(
          color: HBMColors.mediumGrey, // Set the border color to grey
          width: 3, // Set the border width
        ),
        borderRadius:
            BorderRadius.circular(15), // Optional: Add rounded corners
      ),
      child: DropdownButton<String>(
        value: value,
        // Get the current selected item from the provider
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: HBMColors.grey, // Set the icon color to grey
        ),
        elevation: 16,
        // Set the elevation of the dropdown menu
        style: TextStyle(
          color: HBMColors.mediumGrey,
          // Set the text color for the dropdown items
          fontFamily: HBMFonts.quicksandNormal, // Set the font family
        ),
        dropdownColor: HBMColors.coolGrey,
        // Set the dropdown menu background color
        isDense: true,
        // Make the dropdown more compact
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: HBMTextWidget(
              data: value, // Display the dropdown item text
              fontFamily: HBMFonts.quicksandNormal, // Set the font family
            ),
          );
        }).toList(), // Convert the list of items to a list of DropdownMenuItem widgets
      ),
    );
  }
}
