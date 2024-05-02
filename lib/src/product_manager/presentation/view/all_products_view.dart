import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: HBMTextWidget(data: 'Products'),
          actions: [
            Icon(
              Icons.add,
              size: context.width * 0.09,
              color: HBMColors.charcoalGrey,
            ),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: HBMColors.charcoalGrey,
            labelStyle: TextStyle(fontFamily: HBMFonts.quicksandBold),
            unselectedLabelStyle:TextStyle(fontFamily: HBMFonts.quicksandBold),

            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Category'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Center(child: Text('All Tab Content')),
              Center(child: Text('Category Tab Content')),
            ],
          ),
        ),
      ),
    );
  }
}
