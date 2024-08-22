import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/selected_product_category_provider.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/product_manager/presentation/widget/drop_down.dart';
import 'package:husbandman/src/product_manager/presentation/widget/text_field_one.dart';

final deliveryLocationsProvider = StateProvider<List<String>>((ref) {
  return [];
});

class UploadProductForm extends StatefulWidget {
  const UploadProductForm({
    required this.formKey,
    required this.productNameController,
    required this.videoUrlController,
    required this.quantityController,
    required this.priceController,
    required this.descriptionController,
    required this.deliveryLocationsController,
    required this.deliveryDateController,
    required this.measurementController,
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
  final TextEditingController deliveryDateController;
  final TextEditingController measurementController;
  final List<String> items;
  final WidgetRef ref;

  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  @override
  void initState() {
    widget.ref.invalidate(selectedProductCategoryProvider);
    widget.ref.invalidate(deliveryLocationsProvider);
    super.initState();
  }

  List<String> deliveryLocationHelperList = [];

  @override
  Widget build(BuildContext context) {
    var deliveryLocations = widget.ref.watch(deliveryLocationsProvider);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFieldOne(
            controller: widget.productNameController,
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
            controller: widget.videoUrlController,
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
                    controller: widget.quantityController,
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
                    controller: widget.priceController,
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
            controller: widget.descriptionController,
            maxLine: 3,
            labelText: 'Description..',
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
          HBMDropDown(
            value: widget.ref
                .read(
              selectedProductCategoryProvider.notifier,
            )
                .state,
            items: widget.items,
            onChanged: (value) {
              setState(() {
                final defaultValueFromProvider = widget.ref
                    .read(selectedProductCategoryProvider.notifier)
                    .state;

                widget.ref
                    .read(selectedProductCategoryProvider.notifier)
                    .state =
                    value ??
                        defaultValueFromProvider; // Update the selected item state
              });
            },
          ),
          SizedBox(height: context.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: HBMTextWidget(
              data: 'Delivery locations',
              fontFamily: HBMFonts.quicksandBold,
            ),
          ),
          SizedBox(height: context.height * 0.01),
          if (deliveryLocationHelperList.isNotEmpty)
            SizedBox(
              height: context.height * 0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: deliveryLocationHelperList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        child: Card(
                          margin: EdgeInsets.only(
                            right: context.width * 0.02,
                            bottom: context.height * 0.01,
                          ),
                          elevation: 10,
                          color: HBMColors.coolGrey,
                          child: Align(
                            child: Padding(
                              padding: EdgeInsets.all(context.width * 0.03),
                              child: HBMTextWidget(
                                data:
                                deliveryLocationHelperList.elementAt(index),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              deliveryLocationHelperList.removeAt(index);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: HBMColors.mediumGrey,
                          )),
                    ],
                  );
                },
              ),
            ),
          SizedBox(
            height: context.height * 0.01,
          ),
          BreadTextField(
            onChanged: (value) {
              setState(() {});
            },
            cursorColor: HBMColors.mediumGrey,
            fieldController: widget.deliveryLocationsController,
            hintText: 'Add delivery location',
            hintStyle: TextStyle(
              fontFamily: HBMFonts.quicksandBold,
              color: Colors.grey,
            ),
            textStyle: TextStyle(fontFamily: HBMFonts.quicksandNormal),
            suffixIcon: IconButton(
              onPressed: () {
                if (widget.deliveryLocationsController.text
                    .trim()
                    .isEmpty) {
                  return;
                }

                if (deliveryLocationHelperList.contains(
                  widget.deliveryLocationsController.text,
                )) {
                  return;
                }

                setState(() {
                  deliveryLocationHelperList
                      .add(widget.deliveryLocationsController.text.trim());

                deliveryLocations= deliveryLocationHelperList;
               widget.ref
                      .read(deliveryLocationsProvider.notifier)
                      .state = deliveryLocations;

                });

                widget.deliveryLocationsController.clear();

              },
              icon: widget.deliveryLocationsController.text
                  .trim()
                  .isNotEmpty
                  ? const HBMTextWidget(
                data: 'Save',
              )
                  : const SizedBox.shrink(),
            ),
            prefixIcon: const Icon(Icons.place_rounded),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: HBMColors.mediumGrey,
                width: 3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: HBMColors.mediumGrey,
                width: 3,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 3,
              ),
            ),
            validator: (value) {
              if (deliveryLocationHelperList.isEmpty) {
                return 'Delivery location is required';
              }
              if (deliveryLocations != deliveryLocationHelperList) {
                log('List state: $deliveryLocations');
                return 'Delivery not set';
              }
              return null;
            },
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: HBMTextWidget(
              data: 'Delivery date',
              fontFamily: HBMFonts.quicksandBold,
            ),
          ),
          SizedBox(
            height: context.height * 0.01,
          ),
          SizedBox(
            width: context.width,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: HBMFonts.quicksandBold,
                  color: HBMColors.mediumGrey,
                  fontSize: context.width * 0.04,
                  overflow: TextOverflow.visible,
                ),
                children: <InlineSpan>[
                  TextSpan(text: 'The product will be delivered in '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: context.width * 0.35,
                      child: BreadTextField(
                        hintText: '1 day',
                        hintStyle: TextStyle(color: HBMColors.grey),
                        cursorColor: HBMColors.mediumGrey,
                        fieldController: widget.deliveryDateController,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: HBMColors.mediumGrey,
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: HBMColors.mediumGrey,
                            width: 3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Delivery date is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  TextSpan(text: '  after order is placed'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: HBMTextWidget(
              data: 'Measurement',
              fontFamily: HBMFonts.quicksandBold,
            ),
          ),
          SizedBox(
            height: context.height * 0.01,
          ),
          SizedBox(
            width: context.width,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: HBMFonts.quicksandBold,
                  color: HBMColors.mediumGrey,
                  fontSize: context.width * 0.04,
                  overflow: TextOverflow.visible,
                ),
                children: <InlineSpan>[
                  TextSpan(text: 'The price of this product is per '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: context.width * 0.35,
                      child: BreadTextField(
                        hintText: 'e.g kg',
                        hintStyle: TextStyle(color: HBMColors.grey),
                        cursorColor: HBMColors.mediumGrey,
                        fieldController: widget.measurementController,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: HBMColors.mediumGrey,
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: HBMColors.mediumGrey,
                            width: 3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Delivery date is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
