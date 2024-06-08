import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/product_manager/presentation/widget/all_products_category.dart';
import 'package:husbandman/src/product_manager/presentation/widget/all_products_list.dart';

class SellerProductView extends StatelessWidget {
  const SellerProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: HBMTextWidget(
            data: 'Products',
            fontSize: context.width * 0.06,
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
                  size: context.width * 0.09,
                  color: HBMColors.charcoalGrey,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.03),
            unselectedLabelColor: Colors.grey,
            labelColor: HBMColors.charcoalGrey,
            labelStyle: TextStyle(fontFamily: HBMFonts.quicksandBold),
            unselectedLabelStyle: TextStyle(fontFamily: HBMFonts.quicksandBold),
            dividerColor: Colors.grey,
            // indicator: UnderlineTabIndicator(),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: HBMColors.charcoalGrey,
            tabs: const [
              Tab(text: 'Category'),
              Tab(text: 'All'),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
             AllProductsCategories(),
              AllProductsList(),
            ],
          ),
        ),
      ),
    );
  }
}


