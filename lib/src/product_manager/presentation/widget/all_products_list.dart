import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/home_search_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/media_res.dart';

class AllProductsList extends StatelessWidget {
  const AllProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.width * 0.06,
          right: context.width * 0.06,
          top: context.height * 0.02,),
      child: Column(
        children: [
          const SearchField(
            isElevated: true,
            hintText: 'Search product..',
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? context.height * 0.03 : 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: context.width * 0.02,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: HBMColors.mediumGrey,
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            width: context.width * 0.19,
                            height: context.height * 0.07,
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(7),
                              child: SvgPicture.asset(
                                fit: BoxFit.cover,
                                MediaRes.happyFarmer,
                                // width: context.width * 0.15,
                                // height: context.height * 0.07,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: context.width * 0.40,
                                child: const HBMTextWidget(
                                    overflow: TextOverflow.ellipsis,
                                    data:
                                    '29 bags of rice and 40 sweet potatoes',),
                              ),
                              HBMTextWidget(
                                data: '12 weeks',
                                color: HBMColors.grey,
                                fontSize: context.width * 0.03,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: context.width * 0.02,
                        children: [
                          const HBMTextWidget(data: '₦5000'),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: HBMColors.grey,
                            size: context.width * 0.03,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.height * 0.01,),
                  child: Divider(
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
