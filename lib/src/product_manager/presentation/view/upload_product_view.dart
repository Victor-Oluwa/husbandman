import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/picked_product_image_provider.dart';
import 'package:husbandman/core/common/app/provider/product_image_uploaded_notifier.dart';
import 'package:husbandman/core/common/app/provider/product_image_url_provider.dart';
import 'package:husbandman/core/common/app/provider/selected_product_category_provider.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/app/public_methods/loading/loading_controller.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';
import 'package:husbandman/src/product_manager/presentation/widget/drop_down.dart';
import 'package:husbandman/src/product_manager/presentation/widget/text_field_one.dart';

class UploadProductView extends ConsumerStatefulWidget {
  const UploadProductView({super.key});

  @override
  ConsumerState<UploadProductView> createState() => _UploadProductViewState();
}

class _UploadProductViewState extends ConsumerState<UploadProductView> {
  final _formKey = GlobalKey<FormState>();
  final bool pickedImage = false;
  final items = [
    'No Category',
    'Grain',
    'Fruits',
    'Herbs',
    'Vegetables',
    'Tuber',
    'Others',
  ];

  late TextEditingController _productNameController;
  late TextEditingController _videoUrlController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _deliveryLocationsController;

  @override
  void initState() {
    _productNameController = TextEditingController();
    _videoUrlController = TextEditingController();
    _quantityController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
    _deliveryLocationsController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.invalidate(pickedProductImageProvider);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _videoUrlController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _deliveryLocationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.read(
      selectedProductCategoryProvider.notifier,
    );
    return BlocConsumer<ProductManagerBloc, ProductManagerState>(
      listener: (context, state) {
        if (state is PickedProductImage) {
          final seller = ref.read(userProvider);
          context.read<ProductManagerBloc>().add(
                GetProductImageUrlEvent(
                  file: state.files,
                  sellerName: seller.name,
                  isByte: false,
                ),
              );
        }

        if (state is GottenProductImageUrl) {
          ref.read(productImageUrlProvider.notifier).state = state.urls;
          ref.read(productImageUploadedNotifier.notifier).state = true;
          LoadingIndicatorController.instance.hide();
          HBMSnackBar.show(
            context: context,
            content: 'Image saved',
          );
        }

        if (state is ProductUploaded) {
          ref
            ..invalidate(pickedProductImageProvider)
            ..invalidate(productImageUrlProvider)
            ..invalidate(productImageUploadedNotifier)
            ..invalidate(
              selectedProductCategoryProvider,
            );
          HBMSnackBar.show(
            context: context,
            content: 'Product uploaded successfully',
          );

          _productNameController.clear();
          _videoUrlController.clear();
          _quantityController.clear();
          _priceController.clear();
          _descriptionController.clear();
          _deliveryLocationsController.clear();

          LoadingIndicatorController.instance.hide();

          log('Set products: ${ref.watch(generalProductProvider).length}');
        }

        if (state is ProductManagerError) {
          LoadingIndicatorController.instance.hide();
          HBMSnackBar.show(
            context: context,
            content: state.message,
          );
          log(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: HBMColors.coolGrey,
          body: Padding(
            padding: EdgeInsets.only(
              // top: context.height * kHorizontalMargin,
              left: context.height * kVerticalMargin,
              right: context.height * kVerticalMargin,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        context.read<ProductManagerBloc>().add(
                              PickProductImageEvent(),
                            );
                        LoadingIndicatorController.instance.show();
                      },
                      child: SizedBox(
                        height: context.height * 0.20,
                        width: double.maxFinite,
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kCardRadius),
                            side: BorderSide(
                                color: HBMColors.mediumGrey, width: 3),
                          ),
                          elevation: 0,
                          child: ref.watch(pickedProductImageProvider) != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    ref.watch(pickedProductImageProvider)![0],
                                    // fit: BoxFit.fill,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      color: HBMColors.mediumGrey,
                                    ),
                                    HBMTextWidget(
                                      data: 'Tap to add image',
                                      color: HBMColors.mediumGrey,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        _productNameController.text = 'Corn';
                        _videoUrlController.text = 'corn-video.com';
                        _quantityController.text = '5';
                        _priceController.text = '2000000';
                        _descriptionController.text = 'Some description';
                        _deliveryLocationsController.text = 'some locations';
                      },
                      child: HBMTextWidget(
                        data: 'Primary info',
                        fontFamily: HBMFonts.quicksandBold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldOne(
                          controller: _productNameController,
                          labelText: 'Product name',
                          prefixIcon: Icons.text_fields_outlined,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Product name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        TextFieldOne(
                          controller: _videoUrlController,
                          labelText: 'Video URL (Youtube)',
                          prefixIcon: Icons.text_fields_outlined,
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: context.width * 0.42,
                                child: TextFieldOne(
                                  controller: _quantityController,
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
                            SizedBox(
                              width: context.width * 0.03,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: context.width * 0.42,
                                child: TextFieldOne(
                                  controller: _priceController,
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
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        TextFieldOne(
                          controller: _descriptionController,
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
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: HBMTextWidget(
                            data: 'Category',
                            fontFamily: HBMFonts.quicksandBold,
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        HBMDropDown(
                          ref: ref,
                          items: items,
                          // selected: ref
                          //     .read(selectedProductCategoryProvider.notifier)
                          //     .state,
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: HBMTextWidget(
                            data: 'Delivery locations',
                            fontFamily: HBMFonts.quicksandBold,
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        TextFieldOne(
                          controller: _deliveryLocationsController,
                          maxLine: 2,
                          labelText:
                              'Write out the delivery locations for this product.',
                          prefixIcon: Icons.text_fields_outlined,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Delivery location is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: context.height * 0.02,
                        ),
                        TextButton(
                          onPressed: ref.read(productImageUploadedNotifier) ==
                                  true
                              ? () {
                                  if (!_formKey.currentState!.validate() ||
                                      ref.read(
                                              selectedProductCategoryProvider) ==
                                          items[0]) {
                                    HBMSnackBar.show(
                                      context: context,
                                      content:
                                          'Kindly attend to all fields correctly',
                                    );
                                    return;
                                  }

                                  if (ref.read(pickedProductImageProvider) ==
                                      null) {
                                    HBMSnackBar.show(
                                      context: context,
                                      content: 'You have not picked an image',
                                    );
                                    return;
                                  }

                                  if (ref
                                      .read(productImageUrlProvider)
                                      .isNotEmpty) {
                                    LoadingIndicatorController.instance.show();
                                    final urls =
                                        ref.read(productImageUrlProvider);
                                    final user = ref.read(userProvider);

                                    context.read<ProductManagerBloc>().add(
                                          UploadProductEvent(
                                            name: _productNameController.text,
                                            video: _videoUrlController.text,
                                            image: urls,
                                            sellerName: user.name,
                                            sellerEmail: user.email,
                                            available: true,
                                            sold: 0,
                                            quantity: int.parse(
                                                _quantityController.text),
                                            price: double.parse(
                                                _priceController.text),
                                            deliveryTime: '',
                                            description:
                                                _descriptionController.text,
                                            measurement: '',
                                            alwaysAvailable: false,
                                            deliveryLocation: [
                                              _deliveryLocationsController.text,
                                            ],
                                            rating: const [],
                                            likes: 0,
                                          ),
                                        );
                                  }
                                }
                              : null,
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                                context.width * 0.90, context.height * 0.07),
                            backgroundColor: HBMColors.mediumGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: HBMTextWidget(
                            data: 'Upload',
                            color: HBMColors.coolGrey,
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
