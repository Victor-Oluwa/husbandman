import 'package:flutter/material.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/utils/constants.dart';

class ProductListingWidget extends StatelessWidget {
  const ProductListingWidget({
    required this.product,
    required this.index,
    super.key,
  });

  final ProductModel product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 0 ? context.height * 0.03 : 0,
      ),
      child: Stack(
        children: [
          Align(
            child: Container(
              margin: EdgeInsets.only(
                left: context.width * 0.06,
                top: context.height * 0.01,
              ),
              height: context.height * 0.18,
              width: context.width * 0.90,
              decoration: BoxDecoration(
                color: HBMColors.white,
                borderRadius: BorderRadius.circular(context.width * 0.05),
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
            ),
          ),
          //Image Box
          Container(
            height: context.height * 0.17,
            width: context.width * 0.30,
            decoration: BoxDecoration(
              color: HBMColors.charcoalGrey,
              borderRadius: BorderRadius.circular(
                context.width * 0.03,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kCardRadius),
              child: Image.network(fit: BoxFit.cover, product.images[0]),
            ),
          ),
          //Info Background
          Positioned(
            right: context.width * 0.05,
            top: context.height * 0.03,
            child: SizedBox(
              width: context.width * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: HBMTextWidget(
                      data: product.name,
                      fontFamily: HBMFonts.quicksandBold,
                      fontSize: context.width * 0.05,
                      color: HBMColors.charcoalGrey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: HBMTextWidget(
                      data: product.sellerName,
                      color: HBMColors.charcoalGrey,
                      fontFamily: HBMFonts.quicksandNormal,
                      fontSize: context.width * 0.04,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: HBMTextWidget(
                      data: product.deliveryLocations[0],
                      color: HBMColors.charcoalGrey,
                      fontFamily: HBMFonts.quicksandNormal,
                      fontSize: context.width * 0.04,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: HBMTextWidget(
                      data: product.measurement,
                      color: HBMColors.charcoalGrey,
                      fontFamily: HBMFonts.quicksandNormal,
                      fontSize: context.width * 0.03,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Price Text
          Positioned(
            right: context.width * 0.05,
            bottom: context.height * 0.01,
            child: Material(
              color: Colors.transparent,
              child: HBMTextWidget(
                fontFamily: HBMFonts.quicksandBold,
                color: HBMColors.charcoalGrey,
                data: product.price.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
