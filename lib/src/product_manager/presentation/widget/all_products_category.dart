import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/home_search_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/route_names.dart';

class AllProductsCategories extends StatelessWidget {
  const AllProductsCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.06,
        right: context.width * 0.06,
        top: context.height * 0.02,
      ),
      child: Column(
        children: [
          const SearchField(
            isElevated: true,
            hintText: 'Search product..',
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: context.height * 0.02,
                crossAxisSpacing: context.width * 0.02,

              ),
              itemCount: 8,
              padding: EdgeInsets.only(top: context.height * 0.03),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                     
                    },
                    child: const StackedCategoryFolder(),);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StackedCategoryFolder extends StatelessWidget {
  const StackedCategoryFolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: context.height * 0.000 - 0.04,
          child: SizedBox(
            height: context.height * 0.12,
            width: context.width * 0.35,
            child: Card(
              shape: ContinuousRectangleBorder(
                side: BorderSide(color: HBMColors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              color: HBMColors.grey,
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.004,
          child: SizedBox(
            height: context.height * 0.15,
            width: context.width * 0.40,
            child: Card(
              shape: ContinuousRectangleBorder(
                side: BorderSide(color: HBMColors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              color: HBMColors.mediumGrey,
            ),
          ),
        ),
        Positioned(
          // top: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: context.height * 0.17,
                width: context.width * 0.45,
                child: Card(
                  shape: ContinuousRectangleBorder(
                    side: BorderSide(
                      color: HBMColors.mediumGrey,),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: HBMColors.charcoalGrey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SvgPicture.asset(
                      fit: BoxFit.cover,
                      MediaRes.happyFarmer,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: context.width * 0.008,
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    ColoredBox(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: context.width * 0.30,
                        child: HBMTextWidget(
                          data: 'Grains',
                          overflow: TextOverflow.ellipsis,
                          color: HBMColors.charcoalGrey,
                          fontFamily: HBMFonts.quicksandBold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: HBMColors.charcoalGrey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   // top: context.height * 0.15,
        //   // left: context.width * 0.06,
        //   child: Card(
        //     color: HBMColors.charcoalGrey,
        //     margin: EdgeInsets.symmetric(
        //         horizontal: context.width * 0.11),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(
        //         horizontal: context.width * 0.02,
        //         vertical: context.height * 0.004,
        //       ),
        //       child: Row(
        //         mainAxisAlignment:
        //             MainAxisAlignment.spaceBetween,
        //         children: [
        //           Icon(
        //             Icons.card_giftcard,
        //             color: HBMColors.mediumGrey,
        //             size: context.width * 0.04,
        //           ),
        //           HBMTextWidget(
        //             data: '20 products',
        //             fontFamily: HBMFonts.exoBold,
        //             fontSize: context.width * 0.03,
        //             color: HBMColors.mediumGrey,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned(
        //   top: context.height * 0.25,
        //   child: ColoredBox(
        //     color: Colors.transparent,
        //     child: Row(
        //       children: [
        //         HBMTextWidget(
        //           data: 'Grain',
        //           color: HBMColors.charcoalGrey,
        //           fontFamily: HBMFonts.quicksandBold,
        //         ),
        //         SizedBox(
        //           width: context.width * 0.25,
        //         ),
        //         Icon(
        //           Icons.more_vert,
        //           color: HBMColors.charcoalGrey,
        //         )
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
