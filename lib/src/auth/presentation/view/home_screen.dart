// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> {
//

//   @override
//   Widget build(BuildContext context) {
//     final horizontalPadding = context.width * 0.06;
//     return AdvancedDrawer(
//       backdrop: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(color: HBMColors.charcoalGrey),
//       ),
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: const Duration(milliseconds: 300),
//       animateChildDecoration: true,
//       rtlOpening: false,
//       childDecoration: const BoxDecoration(
//         boxShadow: <BoxShadow>[
//           BoxShadow(color: Colors.black12, blurRadius: 0.0),
//         ],
//         borderRadius: BorderRadius.all(Radius.circular(16)),
//       ),
//       drawer: buildDrawer(context),
//       child: buildBody(context, horizontalPadding),
//     );
//   }
//
//   Widget buildBody(BuildContext context, double horizontalPadding) {
//     final allProducts = ref.watch(generalProductProvider);
//
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => ref.read(authBlocProvider)),
//         BlocProvider(create: (context) => ref.read(productManagerBlocProvider)),
//       ],
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade200,
//         appBar: buildAppBar(context),
//         body: MultiBlocListener(
//           listeners: [
//             BlocListener<AuthBloc, AuthState>(
//               listener: (context, state) {
//                 if (state is SignedOut) {
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, RouteNames.signInScreen, (route) => false);
//                 }
//               },
//             ),
//             BlocListener<ProductManagerBloc, ProductManagerState>(
//               listener: (context, state) {
//                 if (state is FetchedProduct) {
//                   log('product fetched from home');
//                   final products = <ProductModel>[];
//
//                   for (final element in state.products) {
//                     products.add(element as ProductModel);
//                   }
//
//                   context.read<ProductManagerBloc>().add(SetGeneralProductEvent(
//                         setProductType: SetProductType.insertNew,
//                         productObject: products,
//                       ));
//                 }
//
//                 if (state is GeneralProductSet) {
//                   log('general product set');
//                 }
//
//                 if (state is ProductManagerError) {
//                   log('An error occurred: ${state.message}');
//                 }
//               },
//             ),
//           ],
//           child: BlocBuilder<ProductManagerBloc, ProductManagerState>(
//             builder: (context, state) {
//               return BlocBuilder<AuthBloc, AuthState>(
//                 builder: (context, state) {
//                   return Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: HBMColors.lightGrey,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           // context.read<AuthBloc>().add(const SignOutEvent());
//                         },
//                         child: Column(
//                           children: [
//                             SizedBox(height: context.height * 0.03),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: horizontalPadding),
//                               child: const SearchField(
//                                   isElevated: false,
//                                   hintText: 'Search anything...'),
//                             ),
//                             SizedBox(height: context.height * 0.03),
//                             SizedBox(
//                               height: context.height * 0.15,
//                               child: ListView(
//                                 scrollDirection: Axis.horizontal,
//                                 children: [
//                                   CategoryWidget(
//                                     content: const HomeCategoryContent.all(),
//                                     color: HBMColors.white,
//                                     leftPadding: context.width * 0.06,
//                                     onTap: () {
//                                       Navigator.pushNamed(context,
//                                           RouteNames.productViewByCategory,
//                                           arguments:
//                                               const HomeCategoryContent.all()
//                                                   .name);
//                                     },
//                                   ),
//                                   CategoryWidget(
//                                     content: const HomeCategoryContent.grain(),
//                                     color: HBMColors.white,
//                                     leftPadding: 0,
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                         context,
//                                         RouteNames.productViewByCategory,
//                                         arguments:
//                                             const HomeCategoryContent.grain()
//                                                 .name,
//                                       );
//                                     },
//                                   ),
//                                   CategoryWidget(
//                                     content: const HomeCategoryContent.herbs(),
//                                     color: HBMColors.white,
//                                     leftPadding: 0,
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                         context,
//                                         RouteNames.productViewByCategory,
//                                         arguments:
//                                             const HomeCategoryContent.herbs()
//                                                 .name,
//                                       );
//                                     },
//                                   ),
//                                   CategoryWidget(
//                                     content:
//                                         const HomeCategoryContent.powdered(),
//                                     color: HBMColors.white,
//                                     leftPadding: 0,
//                                     onTap: () {
//                                       Navigator.pushNamed(context,
//                                           RouteNames.productViewByCategory,
//                                           arguments: const HomeCategoryContent
//                                                   .powdered()
//                                               .name);
//                                     },
//                                   ),
//                                   CategoryWidget(
//                                     content:
//                                         const HomeCategoryContent.vegetables(),
//                                     color: HBMColors.white,
//                                     leftPadding: 0,
//                                     onTap: () {
//                                       Navigator.pushNamed(context,
//                                           RouteNames.productViewByCategory,
//                                           arguments: const HomeCategoryContent
//                                                   .vegetables()
//                                               .name);
//                                     },
//                                   ),
//                                   CategoryWidget(
//                                     content: const HomeCategoryContent.fruits(),
//                                     color: HBMColors.white,
//                                     leftPadding: 0,
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                         context,
//                                         RouteNames.productViewByCategory,
//                                         arguments:
//                                             const HomeCategoryContent.fruits()
//                                                 .name,
//                                       );
//                                     },
//                                   ),
//                                   CategoryWidget(
//                                     content: const HomeCategoryContent.tuber(),
//                                     color: HBMColors.white,
//                                     leftPadding: 0,
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                         context,
//                                         RouteNames.productViewByCategory,
//                                         arguments:
//                                             const HomeCategoryContent.tuber()
//                                                 .name,
//                                       );
//                                     },
//                                   ),
//                                   CategoryWidget(
//                                     content: const HomeCategoryContent.others(),
//                                     color: HBMColors.white,
//                                     leftPadding: 0,
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                         context,
//                                         RouteNames.productViewByCategory,
//                                         arguments:
//                                             const HomeCategoryContent.others()
//                                                 .name,
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: ListView.separated(
//                                 itemCount: allProducts.length,
//                                 controller: _scrollController,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: horizontalPadding),
//                                 itemBuilder: (BuildContext context, index) {
//                                   final product = allProducts[index];
//
//                                   if (index == allProducts.length) {
//                                     return _isLoading
//                                         ? const Center(
//                                             child: CircularProgressIndicator())
//                                         : const SizedBox.shrink();
//                                   }
//                                   return GestureDetector(
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                           context, RouteNames.productDetails,
//                                           arguments: product);
//                                     },
//                                     child: Hero(
//                                       tag: index,
//                                       child: ProductListingWidget(
//                                           product: product, index: index),
//                                     ),
//                                   );
//                                 },
//                                 separatorBuilder:
//                                     (BuildContext context, int index) {
//                                   return SizedBox(
//                                       height: context.height * 0.04);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       toolbarHeight: context.width * 0.20,
//       centerTitle: true,
//       title: GestureDetector(
//         onTap: () {
//           final fetchedProduct = ref
//               .watch(generalProductProvider)
//               .map((product) => product.id)
//               .toList();
//           log('Tapped');
//           context
//               .read<ProductManagerBloc>()
//               .add(FetchProductsEvent(limit: 1, fetched: fetchedProduct));
//         },
//         onDoubleTap: () {
//           LoadingIndicatorController.instance.hide();
//         },
//         child: Column(
//           children: [
//             HBMTextWidget(
//               data: 'Welcome',
//               fontSize: context.width * 0.03,
//               fontFamily: HBMFonts.exoLight,
//               color: Colors.grey,
//             ),
//             HBMTextWidget(
//               data: ref.read(userProvider).name,
//               fontSize: context.width * 0.05,
//               fontFamily: HBMFonts.exoLight,
//             ),
//           ],
//         ),
//       ),
//       leading: IconButton(
//         onPressed: _handleMenuButtonPressed,
//         icon: ValueListenableBuilder<AdvancedDrawerValue>(
//           valueListenable: _advancedDrawerController,
//           builder: (_, value, __) {
//             return AnimatedSwitcher(
//               duration: const Duration(milliseconds: 250),
//               child: Icon(value.visible ? Icons.clear : Icons.menu,
//                   key: ValueKey<bool>(value.visible)),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/injection/product_manager/product_manager_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/domain/entity/home_category_content.dart';
import 'package:husbandman/src/auth/presentation/widgets/drawer.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

final currentCategoryProvider = StateProvider<String>((_) => 'General');
final categoryColorProvider =
    StateProvider<Color>((_) => HBMColors.charcoalGrey);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ProductManagerBloc productManagerBloc;
  late TextEditingController searchController;
  final _advancedDrawerController = AdvancedDrawerController();
  final ScrollController _productGridScrollController = ScrollController();

  // late AnimationController _animationController;
  bool _isLoading = false;

  final options = [
    const HomeCategoryContent.all().name,
    const HomeCategoryContent.fruits().name,
    const HomeCategoryContent.grain().name,
    const HomeCategoryContent.herbs().name,
    const HomeCategoryContent.vegetables().name,
    const HomeCategoryContent.others().name,
    const HomeCategoryContent.powdered().name,
    const HomeCategoryContent.tuber().name,
  ];

  // Method to handle user interactions

  @override
  void initState() {
    super.initState();
    productManagerBloc = ref.read(productManagerBlocProvider);
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProductsByCategory(ref.read(currentCategoryProvider));
      _productGridScrollController.addListener(_scrollListener);
    });
  }

  bool _checkCurrentCategory(String category) {
    final cntCategory = ref.watch(currentCategoryProvider);

    if (cntCategory == category) {
      return true;
    } else {
      return false;
    }
  }

  void _updateCurrentCategoryProvider(String category) {
    setState(() {
      ref.read(currentCategoryProvider.notifier).state = category;
    });
  }

  void _invalidateProductProvider() {
    ref.invalidate(generalProductProvider);
  }

  void _invalidateCurrentCategoryProvider() {
    ref.invalidate(currentCategoryProvider);
  }

  Color _changeCategoryColor(Color categoryColor) {
    var color = categoryColor;
    setState(() {
      color = HBMColors.coolGrey;
    });
    setState(() {});
    return color;
  }

  Future<void> fetchProductsByCategory(String category) async {
    final fetchedProduct =
        ref.read(generalProductProvider).map((product) => product.id).toList();
    if (category == options[0]) {
      productManagerBloc
          .add(FetchProductsEvent(limit: 8, fetched: fetchedProduct));
      setState(() => _isLoading = false);
    } else {
      productManagerBloc.add(
        FetchProductsByCategoryEvent(
          category: category,
          limit: 8,
          fetched: fetchedProduct,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  void addProductToCart(ProductModel product) {
    final userId = ref.read(userProvider).id;
    context.read<ProductManagerBloc>().add(
          AddProductToCartEvent(
            productId: product.id,
            quantity: product.quantity,
            cartOwnerId: userId,
          ),
        );
  }

  void _scrollListener() {
    if (_productGridScrollController.position.pixels ==
        _productGridScrollController.position.maxScrollExtent) {
      log('Reached the end of the list');
      fetchProductsByCategory(ref.read(currentCategoryProvider));
    }
  }

  @override
  void dispose() {
    _productGridScrollController
      ..removeListener(_scrollListener)
      ..dispose();

    _advancedDrawerController.dispose();
    productManagerBloc.close();
    super.dispose();
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(generalProductProvider);
    final currentCategory = ref.watch(currentCategoryProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ref.read(productManagerBlocProvider)),
        BlocProvider(create: (context) => ref.read(authBlocProvider)),
      ],
      child: BreadDrawer(
        advancedDrawerController: _advancedDrawerController,
        tileOneName: 'Dashboard',
        tileOneCallback: () {
          Navigator.pushNamed(context, RouteNames.dashboard);
        },
        tileTwoName: 'Cart',
        tileTwoCallback: () {
          Navigator.pushNamed(context, RouteNames.cartView);
        },
        tileThreeName: 'Orders',
        tileThreeCallback: () {},
        tileFourName: 'Profile',
        tileFourCallback: () {},
        tileFiveName: 'Notification',
        tileFiveCallback: () {},
        tileSixName: 'Logout',
        tileSixCallback: () {},
        pageBody: Scaffold(
          body: BlocConsumer<ProductManagerBloc, ProductManagerState>(
            listener: (context, state) {
              if (state is FetchedProduct) {
                log('product fetched from home');
                final products =
                    state.products.map((e) => e as ProductModel).toList();
                context.read<ProductManagerBloc>().add(
                      SetGeneralProductEvent(
                        setProductType: SetProductType.insertNew,
                        productObject: products,
                      ),
                    );
              }
              if (state is FetchedProductByCategory) {
                final products =
                    state.products.map((e) => e as ProductModel).toList();
                context.read<ProductManagerBloc>().add(
                      SetGeneralProductEvent(
                        setProductType: SetProductType.insertNew,
                        productObject: products,
                      ),
                    );
              }
              if(state is AddProductToCartEvent){
                log('Product added to cart');
              }
              if (state is ProductManagerError) {
                log('An error occurreddd: ${state.message}');
              }
            },
            builder: (context, state) {
              return Container(
                constraints: const BoxConstraints.expand(),
                color: HBMColors.coolGrey,
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SideMenu(
                          ref: ref,
                          options: options,
                          currentCategory: currentCategory,
                          checkCurrentCategory: _checkCurrentCategory,
                          changeCategoryColor: _changeCategoryColor,
                          onMenuButtonPressed: _handleMenuButtonPressed,
                          fetchProductsByCategory: fetchProductsByCategory,
                          updateCurrentCategoryProvider:
                              _updateCurrentCategoryProvider,
                          invalidateProductsProvider:
                              _invalidateProductProvider,
                          invalidateCurrentCategoryProvider:
                              _invalidateCurrentCategoryProvider,
                        ),
                        Expanded(
                          child: ProductGrid(
                            ref: ref,
                            products: products,
                            productGridScrollController:
                                _productGridScrollController,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.04,
                          vertical: context.height * 0.13,
                        ),
                        child: SearchBar(controller: searchController),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Widget for the Side Menu
class SideMenu extends StatefulWidget {
  const SideMenu({
    required this.ref,
    required this.options,
    required this.currentCategory,
    required this.changeCategoryColor,
    required this.onMenuButtonPressed,
    required this.checkCurrentCategory,
    required this.fetchProductsByCategory,
    required this.invalidateProductsProvider,
    required this.updateCurrentCategoryProvider,
    required this.invalidateCurrentCategoryProvider,
    super.key,
  });

  final List<String> options;
  final VoidCallback onMenuButtonPressed;
  final bool Function(String) checkCurrentCategory;
  final void Function(String) fetchProductsByCategory;
  final VoidCallback invalidateProductsProvider;
  final VoidCallback invalidateCurrentCategoryProvider;
  final String currentCategory;
  final WidgetRef ref;
  final void Function(String) updateCurrentCategoryProvider;
  final Color Function(Color) changeCategoryColor;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final ScrollController controller = ScrollController();
  Timer? scrollTimer;
  Timer? userInteractionTimer;
  bool isUserInteracting = false; // To track if the user is interacting
  bool scrollForward = true; // To track the scrolling direction

  String selected = '';

  @override
  void initState() {
    super.initState();
    _startScrollCycle();
  }

  @override
  void dispose() {
    scrollTimer?.cancel();
    userInteractionTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _startScrollCycle() {
    scrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!isUserInteracting) {
        _autoScroll();
      }
    });
  }

  void _onUserInteraction() {
    if (!isUserInteracting) {
      setState(() {
        isUserInteracting = true;
      });
      scrollTimer?.cancel(); // Stop auto-scrolling when the user interacts

      userInteractionTimer?.cancel(); // Reset the inactivity timer
      userInteractionTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          isUserInteracting = false;
        });
        _startScrollCycle();
      });
    }
  }

  void _autoScroll() {
    final maxScroll = controller.position.maxScrollExtent;
    final minScroll = controller.position.minScrollExtent;
    final scrollAmount = 100.0;

    if (scrollForward) {
      controller
          .animateTo(
        (controller.offset + scrollAmount).clamp(minScroll, maxScroll),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      )
          .then((_) {
        scrollForward = false;
      });
    } else {
      controller
          .animateTo(
        (controller.offset - scrollAmount).clamp(minScroll, maxScroll),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      )
          .then((_) {
        scrollForward = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: HBMColors.lightGrey,
      width: context.width * 0.16,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(height: context.height * 0.08),
          IconButton(
            onPressed: widget.onMenuButtonPressed,
            icon: const Icon(Icons.menu),
          ),
          SizedBox(height: context.height * 0.11),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is UserScrollNotification ||
                    scrollNotification is ScrollUpdateNotification) {
                  _onUserInteraction();
                }
                return false;
              },
              child: ListView.builder(
                controller: controller,
                padding: EdgeInsets.zero,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final category = widget.options[index];
                  Color categoryColor = selected == category
                      ? HBMColors.blue // Selected category color
                      : HBMColors.charcoalGrey; // Default category color
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.height * 0.01),
                    child: Align(
                      child: IconButton(
                        onPressed: () {
                          final isCurrentCategory =
                              widget.checkCurrentCategory(category);
                          if (!isCurrentCategory) {
                            setState(() {
                              selected = category;
                            });
                            widget.invalidateProductsProvider();
                            widget.updateCurrentCategoryProvider(category);
                            widget.fetchProductsByCategory(category);
                          }
                        },
                        icon: VerticalText(
                          text: category,
                          color: categoryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the Product Grid
class ProductGrid extends StatelessWidget {
  const ProductGrid({
    required this.products,
    required this.productGridScrollController,
    required this.ref,
    super.key,
  });

  final List<ProductModel> products;
  final ScrollController productGridScrollController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height * 0.15,
        right: context.width * 0.04,
        left: context.width * 0.03,
      ),
      child: GridView.builder(
        controller: productGridScrollController,
        padding: EdgeInsets.only(top: context.height * 0.10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: context.height * 0.02,
          crossAxisSpacing: context.width * 0.03,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product, ref: ref,);
        },
      ),
    );
  }
}

// Widget for the Product Card
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.ref,
  });

  final ProductModel product;
  final WidgetRef ref;

  void addProductToCart({
    required ProductModel product,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    final userId = ref.read(userProvider).id;
    context.read<ProductManagerBloc>().add(
          AddProductToCartEvent(
            productId: product.id,
            quantity: product.quantity,
            cartOwnerId: userId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(product.images[0]),
            ),
            borderRadius: BorderRadius.circular(context.width * 0.04),
            color: HBMColors.lightGrey,
          ),
          child: Container(
            margin: EdgeInsets.only(top: context.height * 0.13),
            padding: EdgeInsets.only(
              top: context.width * 0.01,
              bottom: context.width * 0.01,
              left: context.width * 0.01,
              right: context.width * 0.04,
            ),
            color: Colors.white.withOpacity(0.6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HBMTextWidget(
                  data: product.name,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: HBMFonts.quicksandBold,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HBMTextWidget(
                      data: product.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      fontFamily: HBMFonts.quicksandBold,
                    ),
                    HBMTextWidget(
                      data: 'Per kg',
                      fontSize: context.width * 0.03,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              log('Called');
              addProductToCart(
                product: product,
                ref: ref,
                context: context,
              );
            },
            icon: SizedBox(
              height: context.height * 0.06,
              width: context.width * 0.12,
              child: Card(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(context.width * 0.08),
                    topLeft: Radius.circular(context.width * 0.07),
                    topRight: Radius.circular(context.width * 0.05),
                    bottomLeft: Radius.circular(context.width * 0.02),
                  ),
                ),
                elevation: 0,
                margin: EdgeInsets.zero,
                color: HBMColors.mediumGrey,
                child: Icon(
                  Icons.add,
                  color: HBMColors.coolGrey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget for the Search Bar
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BreadTextField(
      fieldController: controller,
      fillColor: HBMColors.coolGrey,
      filled: true,
      prefixIcon: Icon(
        Icons.search,
        color: HBMColors.charcoalGrey,
      ),
      hintText: 'Search bread..',
      hintStyle: TextStyle(fontFamily: HBMFonts.quicksandNormal),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }
}

// Widget for Vertical Text (unchanged)
class VerticalText extends StatelessWidget {
  const VerticalText({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: HBMTextWidget(
        data: text,
        color: color,
        fontFamily: HBMFonts.quicksandBold,
        fontSize: context.width * 0.04,
      ),
    );
  }
}
