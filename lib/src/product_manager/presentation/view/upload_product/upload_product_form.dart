import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/product_manager/presentation/widget/drop_down.dart';
import 'package:husbandman/src/product_manager/presentation/widget/text_field_one.dart';

class UploadProductForm extends StatelessWidget {
  const UploadProductForm({
    required this.formKey,
    required this.productNameController,
    required this.videoUrlController,
    required this.quantityController,
    required this.priceController,
    required this.descriptionController,
    required this.deliveryLocationsController,
    required this.items,
    required this.ref,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController productNameController;
  final TextEditingController videoUrlController;
  final TextEditingController quantityController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController deliveryLocationsController;
  final List<String> items;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldOne(
            controller: productNameController,
            labelText: 'Product name',
            prefixIcon: Icons.text_fields_outlined,
            validator: (value) {
              if (value == null || value == '') {
                return 'Product name is required';
              }
              return null;
            },
          ),
          SizedBox(height: context.height * 0.01),
          TextFieldOne(
            controller: videoUrlController,
            labelText: 'Video URL (Youtube)',
            prefixIcon: Icons.text_fields_outlined,
          ),
          SizedBox(height: context.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: context.width * 0.42,
                  child: TextFieldOne(
                    controller: quantityController,
                    labelText: 'Quantity',
                    prefixIcon: Icons.text_fields_outlined,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Quantity is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(width: context.width * 0.03),
              Expanded(
                child: SizedBox(
                  width: context.width * 0.42,
                  child: TextFieldOne(
                    controller: priceController,
                    labelText: 'Price',
                    prefixIcon: Icons.text_fields_outlined,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Price is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.height * 0.01),
          TextFieldOne(
            controller: descriptionController,
            maxLine: 3,
            labelText: 'What kind of product is this?',
            prefixIcon: Icons.text_fields_outlined,
            validator: (value) {
              if (value == null || value == '') {
                return 'Description is required';
              }
              return null;
            },
          ),
          SizedBox(height: context.height * 0.01),
          Align(
            alignment: Alignment.centerLeft,
            child: HBMTextWidget(
              data: 'Category',
              fontFamily: HBMFonts.quicksandBold,
            ),
          ),
          SizedBox(height: context.height * 0.01),
          HBMDropDown(ref: ref, items: items),
          SizedBox(height: context.height * 0.01),
          Align(
            alignment: Alignment.centerLeft,
            child: HBMTextWidget(
              data: 'Delivery locations',
              fontFamily: HBMFonts.quicksandBold,
            ),
          ),
          SizedBox(height: context.height * 0.01),
          TextFieldOne(
            controller: deliveryLocationsController,
            maxLine: 2,
            labelText: 'Write out the delivery locations for this product.',
            prefixIcon: Icons.text_fields_outlined,
            validator: (value) {
              if (value == null || value == '') {
                return 'Delivery location is required';
              }
              return null;
            },
          ),
          SizedBox(height: context.height * 0.02),
        ],
      ),
    );
  }
}
