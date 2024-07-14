import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ref.read(authBlocProvider),
  child: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: HBMColors.charcoalGrey),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.04,
                        top: context.height * 0.06,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            minRadius: context.width * 0.09,
                            backgroundImage: NetworkImage(
                              ref.read(generalProductProvider)[1].images[0],
                            ),
                          ),
                          SizedBox(
                            width: context.width * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HBMTextWidget(
                                data: ref.read(userProvider).name,
                                fontSize: context.width * 0.04,
                                fontFamily: HBMFonts.quicksandBold,
                                color: HBMColors.coolGrey,
                              ),
                              HBMTextWidget(
                                data: 'View Profile',
                                fontSize: context.width * 0.03,
                                color: HBMColors.coolGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.03,
                    ),
                    Divider()
                  ],
                ),
                ListTileTheme(
                  dense: true,
                  textColor: HBMColors.mediumGrey,
                  tileColor: HBMColors.mediumGrey,
                  iconColor: HBMColors.coolGrey,
                  // horizontalTitleGap: context.width * 0.10,
                  contentPadding: EdgeInsets.only(
                      left: context.width * 0.04, top: context.height * 0.00),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Customers',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Deposit History',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: HBMColors.coolGrey,
                          size: context.width * 0.03,
                        ),
                        title: HBMTextWidget(
                          data: 'Withdraw History',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Chat',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Settings',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Invoices',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          context.read<AuthBloc>().add(const SignOutEvent());
                        },
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Log Out',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading:
                            Icon(Icons.history, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Cart',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, RouteNames.selectCardView,
                          //     arguments: {
                          //       'expiryDate': '03/30',
                          //       'cardNumber': '370000000000002',
                          //       'cvvCode':'1222',
                          //       'cardHolderName': 'Blue Franker',
                          //       'cardId': '98766556576',
                          //     },);
                          Navigator.pushNamed(context, RouteNames.allCardView);
                        },
                        leading:
                            Icon(Icons.payment, size: context.width * 0.06),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: HBMColors.coolGrey,
                            size: context.width * 0.03),
                        title: HBMTextWidget(
                          data: 'Card',
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.04,
                          color: HBMColors.coolGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        appBar: buildAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: context.height * 0.32,
                width: context.width * 0.95,
                child: Card(
                  elevation: 0,
                  color: HBMColors.mediumGrey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.05,
                      vertical: context.height * 0.03,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            HBMTextWidget(
                              data: '₦50,300,255',
                              color: HBMColors.coolGrey,
                              fontSize: context.width * 0.06,
                              fontFamily: HBMFonts.quicksandBold,
                            ),
                            HBMTextWidget(
                              data: 'Current Balance',
                              color: HBMColors.coolGrey,
                              fontSize: context.width * 0.03,
                            )
                          ],
                        ),
                        Divider(
                          color: HBMColors.coolGrey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                HBMTextWidget(
                                  data: '₦90,322,551',
                                  color: HBMColors.coolGrey,
                                  fontSize: context.width * 0.04,
                                  fontFamily: HBMFonts.quicksandBold,
                                ),
                                HBMTextWidget(
                                  data: 'Total Deposit',
                                  color: HBMColors.coolGrey,
                                  fontSize: context.width * 0.03,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                HBMTextWidget(
                                  data: '17',
                                  color: HBMColors.coolGrey,
                                  fontSize: context.width * 0.04,
                                  fontFamily: HBMFonts.quicksandBold,
                                ),
                                HBMTextWidget(
                                  data: 'Total Transaction',
                                  color: HBMColors.coolGrey,
                                  fontSize: context.width * 0.03,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                HBMTextWidget(
                                  data: '₦33,114,088',
                                  color: HBMColors.coolGrey,
                                  fontSize: context.width * 0.04,
                                  fontFamily: HBMFonts.quicksandBold,
                                ),
                                HBMTextWidget(
                                  data: 'Total Withdrawal',
                                  color: HBMColors.coolGrey,
                                  fontSize: context.width * 0.03,
                                ),
                              ],
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.allCardView,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: HBMColors.coolGrey)),
                          child: HBMTextWidget(
                            data: 'Add Money',
                            color: HBMColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              width: context.width * 0.80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: SizedBox(
                      height: context.height * 0.10,
                      // width: context.width * 0.30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            width: context.width * 0.10,
                            MediaRes.charcoalGreyDepositIcon,
                          ),
                          HBMTextWidget(
                            data: 'Deposit',
                            fontFamily: HBMFonts.quicksandBold,
                            fontSize: context.width * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: SizedBox(
                      height: context.height * 0.10,
                      // width: context.width * 0.30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            width: context.width * 0.10,
                            MediaRes.charcoalGreyWithdrawIcon,
                          ),
                          HBMTextWidget(
                            data: 'Withdraw',
                            fontFamily: HBMFonts.quicksandBold,
                            fontSize: context.width * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.homePage);
                    },
                    icon: SizedBox(
                      height: context.height * 0.10,
                      // width: context.width * 0.30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            width: context.width * 0.10,
                            MediaRes.charcoalGreyShopIcon,
                          ),
                          HBMTextWidget(
                            data: 'Shop',
                            fontFamily: HBMFonts.quicksandBold,
                            fontSize: context.width * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.sellerProducts);
                    },
                    icon: SizedBox(
                      height: context.height * 0.10,
                      // width: context.width * 0.30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            width: context.width * 0.10,
                            MediaRes.charcoalGreyShopIcon,
                          ),
                          HBMTextWidget(
                            data: 'My Products',
                            fontFamily: HBMFonts.quicksandBold,
                            fontSize: context.width * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: context.height * 0.35,
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: HBMColors.mediumGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.width * 0.08),
                      topRight: Radius.circular(context.width * 0.08),
                    ),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(context.width * 0.03),
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.height * 0.02,
                          width: context.width * 0.15,
                          child: Card(color: HBMColors.coolGrey),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: HBMTextWidget(
                                  data: 'Orders',
                                  fontSize: context.width * 0.05,
                                  fontFamily: HBMFonts.quicksandBold,
                                  color: HBMColors.coolGrey,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: HBMTextWidget(
                                  data: 'Expand',
                                  color: HBMColors.coolGrey,
                                  fontSize: context.width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.02,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return ListTileTheme(
                                child: ListTile(
                                  title: HBMTextWidget(
                                    data: 'May, 4, 2025',
                                    fontSize: context.width * 0.04,
                                    fontFamily: HBMFonts.quicksandBold,
                                    color: HBMColors.coolGrey,
                                  ),
                                  subtitle: HBMTextWidget(
                                    data: 'Completed: 2/10',
                                    fontSize: context.width * 0.03,
                                    color: HBMColors.coolGrey,
                                  ),
                                  trailing: HBMTextWidget(
                                    data: '20, 000',
                                    color: HBMColors.coolGrey,
                                  ),
                                  leading: SvgPicture.asset(
                                    width: context.width * 0.10,
                                    MediaRes.coolGreyOrderIcon,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
),
);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: context.width * 0.20,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Column(
        children: [
          HBMTextWidget(
            data: 'Welcome',
            fontSize: context.width * 0.03,
            fontFamily: HBMFonts.exoLight,
            color: Colors.grey,
          ),
          HBMTextWidget(
            data: ref.read(userProvider).name,
            fontSize: context.width * 0.05,
            fontFamily: HBMFonts.exoLight,
          ),
        ],
      ),
      leading: IconButton(
        onPressed: _handleMenuButtonPressed,
        icon: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: _advancedDrawerController,
          builder: (_, value, __) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                value.visible ? Icons.clear : Icons.menu,
                key: ValueKey<bool>(value.visible),
              ),
            );
          },
        ),
      ),
    );
  }
}
