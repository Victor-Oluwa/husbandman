import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/picked_product_image_provider.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/product_image_url_provider.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/selected_product_category_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/app/public_methods/loading/loading_controller.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/auth/domain/entity/home_category_content.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';
import 'package:husbandman/src/product_manager/presentation/view/upload_product/image_picker_widget.dart';
import 'package:husbandman/src/product_manager/presentation/view/upload_product/upload_button_widget.dart';
import 'package:husbandman/src/product_manager/presentation/view/upload_product/upload_product_form.dart';

class ProductUploadBlocConsumerWidget extends StatelessWidget {
  const ProductUploadBlocConsumerWidget({required this.ref, super.key});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final productNameController = TextEditingController();
    final videoUrlController = TextEditingController();
    final quantityController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final deliveryLocationsController = TextEditingController();
    final items = [
      'No Category',
      const HomeCategoryContent.powdered().name,
      const HomeCategoryContent.grain().name,
      const HomeCategoryContent.fruits().name,
      const HomeCategoryContent.herbs().name,
      const HomeCategoryContent.vegetables().name,
      const HomeCategoryContent.tuber().name,
      const HomeCategoryContent.others().name,
    ];

    return BlocConsumer<ProductManagerBloc, ProductManagerState>(
      listener: (context, state) {
        if (state is PickedProductImage) {
          //Update the pickedProductImageProvider with the picked
          //image path
          ref.read(pickedProductImageProvider.notifier).state = state.files;
          LoadingIndicatorController.instance.hide();
          log('Image path picked: ${state.files}');
        }

        if (state is GottenImgUrlFromSupaBase) {
          log('Image Url retrieved: ${state.urls}');

          //Store the image URLs in the productImageUrlProvider
          // ..if the image URLs were retrieved successfully
          ref.read(productImageUrlProvider.notifier).state = state.urls;

          // Validate the form and check if the category is selected correctly
          if (!formKey.currentState!.validate() ||
              ref.read(selectedProductCategoryProvider) == items[0]) {
            HBMSnackBar.show(
                context: context,
                content: 'Kindly attend to all fields correctly',);
            return;
          }

          // Proceed if the image URL is not empty
          if (ref.read(productImageUrlProvider).isNotEmpty) {
            // Get the image Urls and user details from providers
            final urls = ref.read(productImageUrlProvider);
            final user = ref.read(userProvider);

            log('Uploading product');

            // Dispatch an event to upload the product
            context.read<ProductManagerBloc>().add(
                  UploadProductEvent(
                    name: productNameController.text,
                    video: videoUrlController.text,
                    image: urls,
                    sellerName: user.name,
                    sellerEmail: user.email,
                    available: true,
                    sold: 0,
                    quantity: int.parse(quantityController.text),
                    price: double.parse(priceController.text),
                    deliveryTime: '',
                    description: descriptionController.text,
                    measurement: '',
                    alwaysAvailable: false,
                    deliveryLocation: [deliveryLocationsController.text],
                    rating: const [],
                    likes: 0,
                  ),
                );
          }
        }

        if (state is GottenProductImageUrl) {
          HBMSnackBar.show(
            context: context,
            content: 'Image saved',
          );
        }

        if (state is ProductUploaded) {
          //Invalidate provider and clear text fields
          //..when product is uploaded
          ref
            ..invalidate(pickedProductImageProvider)
            ..invalidate(productImageUrlProvider)
            ..invalidate(selectedProductCategoryProvider);
          HBMSnackBar.show(
            context: context,
            content: 'Product uploaded successfully',
          );

          productNameController.clear();
          videoUrlController.clear();
          quantityController.clear();
          priceController.clear();
          descriptionController.clear();
          deliveryLocationsController.clear();

          LoadingIndicatorController.instance.hide();
        }

        if (state is ProductManagerError) {
          LoadingIndicatorController.instance.hide();
          log('ProductManagerError from ProductUploadBlocConsumerWidget: ${state.message}');
          LoadingIndicatorController.instance.hide();
          HBMSnackBar.show(context: context, content: state.message);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: context.height * kVerticalMargin,
            right: context.height * kVerticalMargin,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImagePickerWidget(ref: ref),
                SizedBox(height: context.height * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      productNameController.text = 'Corn';
                      videoUrlController.text = 'corn-video.com';
                      quantityController.text = '5';
                      priceController.text = '2000000';
                      descriptionController.text = 'Some description';
                      deliveryLocationsController.text = 'some locations';
                    },
                    child: HBMTextWidget(
                      data: 'Primary info',
                      fontFamily: HBMFonts.quicksandBold,
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.01),
                UploadProductForm(
                  formKey: formKey,
                  productNameController: productNameController,
                  videoUrlController: videoUrlController,
                  quantityController: quantityController,
                  priceController: priceController,
                  descriptionController: descriptionController,
                  deliveryLocationsController: deliveryLocationsController,
                  items: items,
                  ref: ref,
                ),
                UploadButtonWidget(
                  formKey: formKey,
                  ref: ref,
                  productNameController: productNameController,
                  videoUrlController: videoUrlController,
                  quantityController: quantityController,
                  priceController: priceController,
                  descriptionController: descriptionController,
                  deliveryLocationsController: deliveryLocationsController,
                  items: items,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
