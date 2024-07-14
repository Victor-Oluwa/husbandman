import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/general_product_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/route_names.dart';

class BuyerProfileView extends ConsumerWidget {
  const BuyerProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: HBMColors.coolGrey,
          ),
        ),
      ),
      backgroundColor: HBMColors.coolGrey,
      body: Stack(
        children: [
          // Background and profile info
          Column(
            children: [
              Container(
                height: context.height * 0.40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HBMColors.charcoalGrey,
                  image: DecorationImage(
                    image: NetworkImage(ref.read(generalProductProvider)[0].images[0]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            ref.read(generalProductProvider)[1].images[0]), // replace with actual image URL
                      ),
                      SizedBox(height: 10),
                      HBMTextWidget(
                        data: 'Sam Miler',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HBMColors.white,
                      ),
                      SizedBox(height: 5),
                      HBMTextWidget(
                        data: 'Los Angeles, California',
                        fontSize: 16,
                        color: HBMColors.white,
                      ),
                      SizedBox(height: 5),
                      HBMTextWidget(
                        data: 'Sammiler123@icloud.com',
                        fontSize: 16,
                        color: HBMColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Settings list
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: HBMColors.coolGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.width * 0.07),
                  topRight: Radius.circular(context.width * 0.07),
                ),
              ),
              height: context.height * 0.65,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    minTileHeight: context.height*0.08,
                    leading: Icon(Icons.message),
                    title: HBMTextWidget(
                        color: HBMColors.charcoalGrey, data: 'Messages'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    minTileHeight: context.height*0.08,
                    leading: Icon(Icons.notifications),
                    title: HBMTextWidget(
                        color: HBMColors.charcoalGrey, data: 'Notifications'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    minTileHeight: context.height*0.08,
                    leading: Icon(Icons.settings),
                    title: HBMTextWidget(
                        color: HBMColors.charcoalGrey, data: 'Settings'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, RouteNames.cartView);
                    },
                    minTileHeight: context.height*0.08,
                    leading: Icon(Icons.shopping_cart),
                    title: HBMTextWidget(
                        color: HBMColors.charcoalGrey, data: 'Cart'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    minTileHeight: context.height*0.08,
                    leading: Icon(Icons.history),
                    title: HBMTextWidget(
                        color: HBMColors.charcoalGrey, data: 'Records'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    minTileHeight: context.height*0.08,
                    leading: Icon(Icons.help),
                    title:
                        HBMTextWidget(color: HBMColors.charcoalGrey, data: 'Help'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    minTileHeight: context.height*0.08,
                    leading: Icon(Icons.logout),
                    title:
                    HBMTextWidget(color: HBMColors.charcoalGrey, data: 'Logout'),
                    trailing: Icon(Icons.arrow_forward_ios),
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
