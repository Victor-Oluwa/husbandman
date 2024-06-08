import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/product_manager/presentation/widget/all_products_list.dart';

class SellerProductViewByCategory extends StatelessWidget {
  const SellerProductViewByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: HBMTextWidget(
          data: 'Grains',
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, RouteNames.addProduct);
            },
            child: Padding(
              padding: EdgeInsets.only(right: context.width*0.05),
              child: Icon(
                Icons.add,
                color: HBMColors.charcoalGrey,
                size: context.width * 0.09,
              ),
            ),
          )
        ],
      ),
      body: const AllProductsList(),
    );
  }
}
