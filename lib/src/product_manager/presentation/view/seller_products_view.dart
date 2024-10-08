import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/general_product_provider.dart';
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
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

final currentCategoryProvider = StateProvider<String>((_) => 'General');
final categoryColorProvider =
    StateProvider<Color>((_) => HBMColors.charcoalGrey);

class SellerProductView extends ConsumerStatefulWidget {
  const SellerProductView({super.key});

  @override
  ConsumerState<SellerProductView> createState() => _SellerProductViewState();
}

class _SellerProductViewState extends ConsumerState<SellerProductView>
    with SingleTickerProviderStateMixin {
  late ProductManagerBloc productManagerBloc;
  late TextEditingController searchController;
  final _advancedDrawerController = AdvancedDrawerController();
  final ScrollController _productListScrollController = ScrollController();

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
      setState(() {});
    } else {
      productManagerBloc.add(
        FetchProductsByCategoryEvent(
          category: category,
          limit: 8,
          fetched: fetchedProduct,
        ),
      );
      setState(() {});
    }
  }

  void _scrollListener() {
    if (_productListScrollController.position.pixels ==
        _productListScrollController.position.maxScrollExtent) {
      log('Reached the end of the list');
      fetchProductsByCategory(ref.read(currentCategoryProvider));
    }
  }

  @override
  void dispose() {
    _productListScrollController
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
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignedOut) {
            log('User signed out');
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.signInScreen,
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                if (state is AddProductToCartEvent) {
                  log('Product added to cart');
                }
                if (state is ProductManagerError) {
                  log('An error occurred: ${state.message}');
                }
              },
              builder: (context, state) {
                return Container(
                  constraints: const BoxConstraints.expand(),
                  color: HBMColors.coolGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: context.height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.04,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                HBMTextWidget(
                                  data: 'Manage',
                                  fontSize: context.width * 0.08,
                                  fontFamily: HBMFonts.quicksandBold,
                                ),
                                HBMTextWidget(
                                  data: 'Products',
                                  fontFamily: HBMFonts.quicksandBold,
                                  fontSize: context.width * 0.11,
                                  color: HBMColors.mediumGrey,
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.addProduct);
                              },
                              icon: Icon(
                                Icons.add,
                                size: context.width*0.15,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.04,
                          // vertical: context.height * 0.13,
                        ),
                        child: SearchBar(controller: searchController),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
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
                                productListScrollController:
                                    _productListScrollController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
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
    // _startScrollCycle();
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
    const scrollAmount = 100.0;

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
      padding: EdgeInsets.only(top: context.height * 0.03),
      alignment: Alignment.center,
      width: context.width * 0.16,
      height: context.height * 0.70,
      decoration: BoxDecoration(
        color: HBMColors.mediumGrey,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(context.width * 0.13),
        ),
      ),
      child: ListView.builder(
        controller: controller,
        padding: EdgeInsets.zero,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final category = widget.options[index];
          final categoryColor = selected == category
              ? HBMColors.blue // Selected category color
              : HBMColors.lightGrey; // Default category color
          return Padding(
            padding: EdgeInsets.only(bottom: context.height * 0.01),
            child: IconButton(
              onPressed: () {
                final isCurrentCategory = widget.checkCurrentCategory(category);
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
          );
        },
      ),
    );
  }
}

// Widget for the Product Grid
class ProductGrid extends StatelessWidget {
  const ProductGrid({
    required this.products,
    required this.productListScrollController,
    required this.ref,
    super.key,
  });

  final List<ProductModel> products;
  final ScrollController productListScrollController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height * 0.00,
        right: context.width * 0.04,
        left: context.width * 0.03,
      ),
      child: ListView.builder(
        controller: productListScrollController,
        padding: EdgeInsets.only(top: context.height * 0.03),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            ref: ref,
          );
        },
      ),
    );
  }
}

// Widget for the Product Card
class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.product,
    required this.ref,
    super.key,
  });

  final ProductEntity product;
  final WidgetRef ref;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late PageController productSwipePageViewController;

  @override
  void initState() {
    productSwipePageViewController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    productSwipePageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            log('${productSwipePageViewController.page}');
            if (productSwipePageViewController.page != 0.0) {
              productSwipePageViewController.previousPage(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn,
              );
              return;
            }
            productSwipePageViewController.nextPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          },
          child: SizedBox(
            width: context.width,
            height: context.height * 0.30,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: context.height * 0.01),
              color: HBMColors.lightGrey,
              child: PageView(
                controller: productSwipePageViewController,
                children: [
                  Card(
                    elevation: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        context.width * 0.03,
                      ),
                      child: Image.network(
                        fit: BoxFit.cover,
                        widget.product.images[0],
                      ),
                    ),
                    margin: EdgeInsets.zero,
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.width*0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HBMTextWidget(data: 'Name: '),
                            HBMTextWidget(data: widget.product.name),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HBMTextWidget(data: 'Price: '),
                            HBMTextWidget(data: widget.product.price.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HBMTextWidget(data: 'Quantity available: '),
                            HBMTextWidget(data: widget.product.quantityAvailable.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HBMTextWidget(data: 'Sold: '),
                            HBMTextWidget(data: widget.product.numberSold.toString()),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: context.height * 0.02,
          right: context.width * 0.03,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
            },
            icon: SizedBox(
              height: context.height * 0.08,
              width: context.height * 0.08,
              child: Card(
                shape: const CircleBorder(),
                elevation: 0,
                margin: EdgeInsets.zero,
                color: Colors.white.withOpacity(0.3),
                child: Icon(
                  Icons.edit,
                  color: HBMColors.charcoalGrey,
                  size: context.width * 0.07,
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
    required this.controller,
    super.key,
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
  const VerticalText({required this.text, required this.color, super.key});

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
