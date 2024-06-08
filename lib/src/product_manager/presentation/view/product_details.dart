import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class ProductDetailsView extends ConsumerWidget {
  const ProductDetailsView({required this.product, super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: context.height * 0.45,
              width: double.infinity,
              child: Card(
                shape: const BeveledRectangleBorder(),
                margin: EdgeInsets.zero,
                color: Colors.black,
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: context.height * 0.60,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  margin: EdgeInsets.zero,
                  color: HBMColors.coolGrey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.width * 0.05,
                      right: context.width * 0.05,
                      top: context.height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HBMTextWidget(
                              data: product.name,
                              fontSize: context.width * 0.06,
                              fontFamily: HBMFonts.quicksandBold,
                            ),
                            Wrap(
                              children: [
                                Icon(Icons.star),
                                SizedBox(
                                  width: context.width * 0.02,
                                ),
                                HBMTextWidget(data: '${product.rating.length}'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(product.images[0]),
                                ),
                                SizedBox(
                                  width: context.width * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HBMTextWidget(
                                      data: product.sellerName,
                                      fontFamily: HBMFonts.quicksandBold,
                                    ),
                                    HBMTextWidget(
                                      data:
                                          '${user.customers.length} customers',
                                      fontSize: context.width * 0.04,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            HBMTextWidget(
                              data: '₦${product.price}',
                              fontFamily: HBMFonts.quicksandBold,
                              fontSize: context.width * 0.05,
                            )
                          ],
                        ),
                        SizedBox(
                          height: context.height * 0.03,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: HBMColors.grey)),
                            margin: EdgeInsets.zero,
                            color: Colors.transparent,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Wrap(
                                        children: [
                                          Wrap(
                                            children: [
                                              Icon(Icons.thumb_up),
                                              SizedBox(
                                                width: context.width * 0.01,
                                              ),
                                              HBMTextWidget(data: '0')
                                            ],
                                          ),
                                          SizedBox(
                                            width: context.width * 0.10,
                                          ),
                                          Column(
                                            children: [
                                              Wrap(
                                                children: [
                                                  HBMTextWidget(data: '0'),
                                                  SizedBox(
                                                    width: context.width * 0.01,
                                                  ),
                                                  Icon(Icons.thumb_down),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: context.height*0.02),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor: HBMColors.mediumGrey,
                                          minimumSize: Size(
                                            context.width * 0.30,
                                            context.height * 0.04,
                                          ),
                                        ),
                                        child: HBMTextWidget(
                                          data: 'Add to Cart',
                                          fontFamily: HBMFonts.exo2,
                                          color: HBMColors.coolGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor: HBMColors.mediumGrey,
                                          minimumSize: Size(
                                            context.width * 0.30,
                                            context.height * 0.04,
                                          ),
                                        ),
                                        child: HBMTextWidget(
                                          data: 'Customerise',
                                          fontFamily: HBMFonts.exo2,
                                          color: HBMColors.coolGrey,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                HBMColors.mediumGrey,
                                            minimumSize: Size(
                                              context.width * 0.30,
                                              context.height * 0.04,
                                            ),),
                                        child: HBMTextWidget(
                                          data: 'Message',
                                          fontFamily: HBMFonts.exo2,
                                          color: HBMColors.coolGrey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.03,
                        ),
                        HBMTextWidget(
                          data: 'Product Description',
                          fontFamily: HBMFonts.quicksandBold,
                        ),
                        HBMTextWidget(
                            textAlign: TextAlign.left,
                            data:
                                'Im currently filling out the form for the IDAN showroom visit, but Im not sure what should go in these fields Sir, Im currently filling out the form for the IDAN showroom visit, but Im not sure what should go in these fieldsSir, Im currently filling out the form for the IDAN showroom visit, but Im not sure what should go in these fields'),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        HBMTextWidget(
                          data: 'Delivery Locations',
                          fontFamily: HBMFonts.quicksandBold,
                        ),
                        HBMTextWidget(
                          data: product.deliveryLocations[0],
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        HBMTextWidget(
                          data: 'Availability',
                          fontFamily: HBMFonts.quicksandBold,
                        ),
                        HBMTextWidget(
                            data: product.available == true
                                ? 'In Stock'
                                : 'Out of Stock'),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        HBMTextWidget(
                          data: 'Quantity Left',
                          fontFamily: HBMFonts.quicksandBold,
                        ),
                        HBMTextWidget(data: product.quantity.toString()),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        HBMTextWidget(
                          data: 'Sold',
                          fontFamily: HBMFonts.quicksandBold,
                        ),
                        HBMTextWidget(
                          data: product.sold.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: context.height * 0.03),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SizedBox(
                  height: context.height * 0.06,
                  width: context.width * 0.12,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: HBMColors.coolGrey,
                    elevation: 10,
                    child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: HBMColors.charcoalGrey,
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
