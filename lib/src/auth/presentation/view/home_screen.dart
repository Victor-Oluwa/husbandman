import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/fetched_products_provider.dart';
import 'package:husbandman/core/common/app/provider/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/app/public_methods/loading/loading_controller.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/home_search_widget.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/widgets/product_listing_widget.dart';
import 'package:husbandman/src/auth/domain/entity/home_category_content.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

import '../widgets/category_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log('Reached the end of the list');
      fetchProducts();
    }
  }

  Future<void> fetchProducts() async {
    final fetchedProduct = ref
        .read(generalProductProvider)
        .map(
          (product) => product.id,
        )
        .toList();

    context.read<ProductManagerBloc>().add(
          FetchProductsEvent(
            limit: 5,
            fetched: fetchedProduct,
          ),
        );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchProducts();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    _advancedDrawerController.dispose();
    super.dispose();
  }

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
    final allProducts = ref.watch(generalProductProvider);

    return Scaffold(
      appBar: buildAppBar(context),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignedOut) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.signInScreen,
                  (route) => false,
                );
              }
            },
          ),
          BlocListener<ProductManagerBloc, ProductManagerState>(
            listener: (context, state) {
              if (state is FetchedProduct) {
                log('product fetched from home');
                final products = <ProductModel>[];

                for (final element in state.products) {
                  products.add(element as ProductModel);
                }

                context.read<ProductManagerBloc>().add(
                      SetGeneralProductEvent(
                        setProductType: SetProductType.insertNew,
                        productObject: products,
                      ),
                    );
              }

              if (state is ProductManagerError) {
                log('An error occurred: ${state.message}');
              }
            },
          ),
        ],
        child: BlocBuilder<ProductManagerBloc, ProductManagerState>(
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HBMColors.coolGrey,
                      borderRadius: const BorderRadius.only(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding),
                            child: const SearchField(
                              isElevated: true,
                              hintText: 'Search anything...',
                            ),
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
                                  content: const HomeCategoryContent.all(),
                                  color: HBMColors.white,
                                  leftPadding: context.width * 0.06,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productViewByCategory,
                                      arguments:
                                          const HomeCategoryContent.all().name,
                                    );
                                  },
                                ),
                                CategoryWidget(
                                  content: const HomeCategoryContent.grain(),
                                  color: HBMColors.white,
                                  leftPadding: 0,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productViewByCategory,
                                      arguments:
                                          const HomeCategoryContent.grain()
                                              .name,
                                    );
                                  },
                                ),
                                CategoryWidget(
                                  content: const HomeCategoryContent.herbs(),
                                  color: HBMColors.white,
                                  leftPadding: 0,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productViewByCategory,
                                      arguments:
                                          const HomeCategoryContent.herbs()
                                              .name,
                                    );
                                  },
                                ),
                                CategoryWidget(
                                  content: const HomeCategoryContent.powdered(),
                                  color: HBMColors.white,
                                  leftPadding: 0,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productViewByCategory,
                                      arguments:
                                          const HomeCategoryContent.powdered()
                                              .name,
                                    );
                                  },
                                ),
                                CategoryWidget(
                                  content:
                                      const HomeCategoryContent.vegetables(),
                                  color: HBMColors.white,
                                  leftPadding: 0,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productViewByCategory,
                                      arguments:
                                          const HomeCategoryContent.vegetables()
                                              .name,
                                    );
                                  },
                                ),
                                CategoryWidget(
                                  content: const HomeCategoryContent.tools(),
                                  color: HBMColors.white,
                                  leftPadding: 0,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productViewByCategory,
                                      arguments:
                                          const HomeCategoryContent.tools()
                                              .name,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: allProducts.length,
                              controller: _scrollController,
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                              ),
                              itemBuilder: (BuildContext context, index) {
                                final product = allProducts[index];

                                if (index == allProducts.length) {
                                  return _isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : const SizedBox.shrink();
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productDetails,
                                      arguments: product,
                                    );
                                  },
                                  child: Hero(
                                    tag: index,
                                    child: ProductListingWidget(
                                      product: product,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
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
                );
              },
            );
          },
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
            textColor: HBMColors.mediumGrey,
            tileColor: HBMColors.mediumGrey,
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
                    color: HBMColors.coolGrey,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.dashboard);
                  },
                  leading: Icon(
                    Icons.dashboard,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'Dashboard',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.buyerProfile);
                  },
                  leading: Icon(
                    Icons.person_2,
                    size: context.width * 0.08,
                  ),
                  title: HBMTextWidget(
                    data: 'Profile',
                    fontFamily: HBMFonts.quicksandNormal,
                    fontSize: context.width * 0.04,
                    color: HBMColors.coolGrey,
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
                    color: HBMColors.coolGrey,
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
                    color: HBMColors.coolGrey,
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
                    color: HBMColors.coolGrey,
                  ),
                ),
                // Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    child: HBMTextWidget(
                      data: 'Terms of Service | Privacy Policy',
                      fontFamily: HBMFonts.quicksandNormal,
                      color: HBMColors.coolGrey,
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
      toolbarHeight: context.width * 0.20,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          final fetchedProduct = ref
              .watch(generalProductProvider)
              .map(
                (product) => product.id,
              )
              .toList();
          // log('message');
          // LoadingIndicatorController.instance.show();
          log('Tapped');
          context.read<ProductManagerBloc>().add(
                FetchProductsEvent(
                  limit: 1,
                  fetched: fetchedProduct,
                ),
              );
          // setState(() {});
        },
        onDoubleTap: () {
          LoadingIndicatorController.instance.hide();
        },
        child: Column(
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
