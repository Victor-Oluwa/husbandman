import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/picked_product_image_provider.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/selected_product_category_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/app/public_methods/loading/loading_controller.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

/// A widget that represents an upload button for uploading product details.
///
/// The [UploadButtonWidget] uses Riverpod for state management and Bloc for
/// handling events related to product management. It validates the form and checks
/// required fields before allowing the upload action.

class UploadButtonWidget extends StatelessWidget {
  /// Creates an [UploadButtonWidget].
  ///
  /// The [ref], [productNameController], [videoUrlController],
  /// [quantityController], [priceController], [descriptionController],
  /// [deliveryLocationsController], and [items] parameters are required and
  /// must not be null.
  const UploadButtonWidget({
    required this.ref,
    required this.productNameController,
    required this.videoUrlController,
    required this.quantityController,
    required this.priceController,
    required this.descriptionController,
    required this.deliveryLocationsController,
    required this.items,
    required this.formKey,
    super.key,
  });

  /// A key to access the form state.
  final GlobalKey<FormState> formKey;

  /// A reference to the Riverpod provider.
  final WidgetRef ref;

  /// Controller for the product name input field.
  final TextEditingController productNameController;

  /// Controller for the video URL input field.
  final TextEditingController videoUrlController;

  /// Controller for the quantity input field.
  final TextEditingController quantityController;

  /// Controller for the price input field.
  final TextEditingController priceController;

  /// Controller for the description input field.
  final TextEditingController descriptionController;

  /// Controller for the delivery locations input field.
  final TextEditingController deliveryLocationsController;

  /// A list of items representing product categories.
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Validate the form and check if the category is selected correctly
        if (!formKey.currentState!.validate() ||
            ref.read(selectedProductCategoryProvider) == items[0]) {
          HBMSnackBar.show(
            context: context,
            content: 'Kindly attend to all fields correctly',
          );
          return;
        }

        // Check if an image has been picked
        if (ref.read(pickedProductImageProvider) == null) {
          HBMSnackBar.show(
            context: context,
            content: 'You have not picked an image',
          );
          return;
        }

        if(ref.read(selectedProductCategoryProvider).isEmpty){
          HBMSnackBar.show(
            context: context,
            content: 'You have not selected a category',
          );
          return;
        }

        // Show loading indicator
        LoadingIndicatorController.instance.show();

        // Get the image paths from provider
        final pickedImagePaths =
            ref.read(pickedProductImageProvider.notifier).state;

        // Dispatch an event to upload get picked images Urls
        context.read<ProductManagerBloc>().add(
              GetImgUrlFromSupaBaseEvent(
                filePaths: pickedImagePaths ?? [],
                folderPath: 'Owner Id: ${ref.read(userProvider).id}',
              ),
            );
      },
      style: OutlinedButton.styleFrom(
        elevation: 5,
        fixedSize: Size(context.width, context.height * 0.07),
        // Set button size
        // backgroundColor: HBMColors.mediumGrey,
        // Set background color
        side: BorderSide(
          color: HBMColors.mediumGrey,
          width: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          /*

          * */
        ), // Set shape with rounded corners
      ),
      child: HBMTextWidget(
        data: 'Upload',
        color: HBMColors.mediumGrey,
        fontSize: context.width * 0.05,
      ), // Set button text and color
    );
  }
}
