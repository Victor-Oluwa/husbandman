import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/home_search_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/domain/entity/home_category_content.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

import '../widgets/category_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.width * 0.06;
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: HBMColors.charcoalGrey),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      drawer: buildDrawer(context),
      child: buildBody(context, horizontalPadding),
    );
  }

  Scaffold buildBody(BuildContext context, double horizontalPadding) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignedOut) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.signInScreen,
              (route) => false,
            );
          } else {
            log(state.toString());
          }
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: HBMColors.coolGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                // context.read<AuthBloc>().add(const SignOutEvent());
              },
              child: Column(
                children: [
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: SearchBar(),
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  SizedBox(
                    height: context.height * 0.15,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoryWidget(
                          content: const HomeCategoryContent.grain(),
                          color: HBMColors.white,
                          leftPadding: context.width * 0.06,
                          onTap: () {},
                        ),
                        CategoryWidget(
                          content: const HomeCategoryContent.herbs(),
                          color: HBMColors.white,
                          leftPadding: 0,
                          onTap: () {},
                        ),
                        CategoryWidget(
                          content: const HomeCategoryContent.powdered(),
                          color: HBMColors.white,
                          leftPadding: 0,
                          onTap: () {},
                        ),
                        CategoryWidget(
                          content: const HomeCategoryContent.vegetables(),
                          color: HBMColors.white,
                          leftPadding: 0,
                          onTap: () {},
                        ),
                        CategoryWidget(
                          content: const HomeCategoryContent.tools(),
                          color: HBMColors.white,
                          leftPadding: 0,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: context.height * 0.05,
                  // ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 7,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      itemBuilder: (BuildContext context, index) {
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
                                    borderRadius: BorderRadius.circular(
                                        context.width * 0.05),
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
                              Container(
                                height: context.height * 0.17,
                                width: context.width * 0.30,
                                decoration: BoxDecoration(
                                  color: HBMColors.charcoalGrey,
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.03),
                                ),
                              ),
                              Positioned(
                                right: context.width * 0.05,
                                top: context.height * 0.03,
                                child: SizedBox(
                                  width: context.width * 0.50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      HBMTextWidget(
                                        data: 'Abbys (1 bag)',
                                        fontFamily: HBMFonts.quicksandBold,
                                        fontSize: context.width * 0.05,
                                        color: HBMColors.charcoalGrey,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      HBMTextWidget(
                                        data: 'Mr Okon',
                                        color: HBMColors.charcoalGrey,
                                        fontFamily: HBMFonts.quicksandNormal,
                                        fontSize: context.width * 0.04,
                                      ),
                                      HBMTextWidget(
                                        data: '2, Peace street, Ijeododo lagos',
                                        color: HBMColors.charcoalGrey,
                                        fontFamily: HBMFonts.quicksandNormal,
                                        fontSize: context.width * 0.04,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: context.height * 0.01,
                                      ),
                                      HBMTextWidget(
                                        data: '2 Bags | Organic',
                                        color: HBMColors.charcoalGrey,
                                        fontFamily: HBMFonts.quicksandNormal,
                                        fontSize: context.width * 0.03,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: context.width * 0.05,
                                bottom: context.height * 0.01,
                                child: HBMTextWidget(
                                  fontFamily: HBMFonts.quicksandBold,
                                  color: HBMColors.charcoalGrey,
                                  data: '₦2000',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: context.height * 0.04,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SafeArea buildDrawer(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          // margin: ,
          child: ListTileTheme(
            textColor: HBMColors.coolGrey,
            iconColor: HBMColors.coolGrey,
            horizontalTitleGap: context.width * 0.10,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.width * 0.08,
              vertical: context.height * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.home_filled,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'Home',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.dashboard,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'Dashboard',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.favorite,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'Liked',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                  ),
                ),

                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.people_alt_rounded,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'Customers',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.history,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'History',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.settings,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'Settings',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                  ),
                ),
                // Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    child: HBMTextWidget(
                      data: 'Terms of Service | Privacy Policy',
                      fontFamily: HBMFonts.quicksandNormal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: HBMColors.white,
      toolbarHeight: context.width * 0.20,
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
