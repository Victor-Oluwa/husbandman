import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/category_product_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/general_product_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/home_search_widget.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/services/injection/product_manager/product_manager_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/core_utils.dart';
import 'package:husbandman/core/widgets/product_listing_widget.dart';
import 'package:husbandman/src/auth/domain/entity/home_category_content.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

class ProductViewByCategory extends ConsumerStatefulWidget {
  const ProductViewByCategory({required this.category, super.key});

  final String category;

  @override
  ConsumerState<ProductViewByCategory> createState() =>
      _ProductViewByCategoryState();
}

class _ProductViewByCategoryState extends ConsumerState<ProductViewByCategory> {
  late ProductManagerBloc productManagerBloc;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log('Reached the end of the list');

      if (widget.category == const HomeCategoryContent.all().name) {
        fetchProducts();
      } else {
        fetchProductsByCategory();
      }
    }
  }

  Future<void> fetchProductsByCategory() async {
    final fetchedProduct = ref
        .read(categoryProductProvider)
        .map(
          (product) => product.id,
        )
        .toList();
    CoreUtils.hbmLogTerminal(
      message:
          'fetchProductsByCategory called; Items already in category product provider $fetchedProduct',
      fromClass: 'ProductViewByCategory',
    );
    productManagerBloc.add(
      FetchProductsByCategoryEvent(
        category: widget.category,
        limit: 5,
        fetched: fetchedProduct,
      ),
    );

    setState(() {
      _isLoading = false;
    });

    // productManagerBloc.
  }

  Future<void> fetchProducts() async {
    final fetchedProduct =
        ref.read(generalProductProvider).map((product) => product.id).toList();

    CoreUtils.hbmLogTerminal(
        message:
            'fetchProducts called; Items already in general product provider $fetchedProduct',
        fromClass: 'ProductViewByCategory');

    productManagerBloc.add(
      FetchProductsEvent(
        limit: 2,
        fetched: fetchedProduct,
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productManagerBloc = ref.read(productManagerBlocProvider);
    ref.invalidate(categoryProductProvider);

    if (widget.category != const HomeCategoryContent.all().name) {
      fetchProductsByCategory();
    }
  }

  @override
  void initState() {
    productManagerBloc = ref.read(productManagerBlocProvider);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    productManagerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = ref.watch(generalProductProvider);
    final categoryProduct = ref.watch(categoryProductProvider);
    return BlocProvider(
      create: (context) => ref.read(productManagerBlocProvider),
      child: Scaffold(
        appBar: AppBar(
          title: HBMTextWidget(
            data: widget.category,
          ),
        ),
        body: BlocConsumer<ProductManagerBloc, ProductManagerState>(
          listener: (context, state) {
            if (state is FetchedProduct) {
              for (var i = 0; i < state.products.length; i++) {
                CoreUtils.hbmLogTerminal(
                  message:
                      'Category product was fetched: ${state.products[i].type}: Name: ${state.products[i].name}',
                  fromClass: 'ProductViewByCategory',
                );
              }

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

            if (state is FetchedProductByCategory) {
              for (var i = 0; i < state.products.length; i++) {
                CoreUtils.hbmLogTerminal(
                  message:
                      'Category product was fetched: ${state.products[i].type}: Name: ${state.products[i].name}',
                  fromClass: 'ProductViewByCategory',
                );
              }
              final products = <ProductModel>[];

              for (final element in state.products) {
                products.add(element as ProductModel);
              }

              if (products.isNotEmpty) {
                ref.read(categoryProductProvider.notifier).addNewProduct(
                      newProductModel: products,
                    );
              }
            }

            // TODO: Create function for setCategoryProduct

            if (state is ProductManagerError) {
              log('Error log from ProductViewByCategory class: An error occurred: ${state.message}');
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: context.height * 0.06),
                            child: ListView.separated(
                              controller: _scrollController,
                              itemCount: widget.category ==
                                      const HomeCategoryContent.all().name
                                  ? allProducts.length
                                  : categoryProduct.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.width * 0.05,
                                      vertical: context.height * 0.01),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.productDetails,
                                        arguments: widget.category ==
                                                const HomeCategoryContent.all()
                                                    .name
                                            ? allProducts[index]
                                            : categoryProduct[index],
                                      );
                                    },
                                    child: Hero(
                                      tag: index,
                                      child: ProductListingWidget(
                                        product: widget.category ==
                                                const HomeCategoryContent.all()
                                                    .name
                                            ? allProducts[index]
                                            : categoryProduct[index],
                                        index: index,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: context.height * 0.02),
                        child: SizedBox(
                          width: context.width * 0.90,
                          child: const SearchField(
                            isElevated: true,
                            hintText: 'Search',
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
      ),
    );
  }
}
