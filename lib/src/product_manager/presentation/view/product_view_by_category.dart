import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/category_product_provider.dart';
import 'package:husbandman/core/common/app/provider/general_product_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/home_search_widget.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/services/route_names.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log('Reached the end of the list');

      if (widget.category == const HomeCategoryContent.all().name) {
        fetchProducts();
      }else{
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

    context.read<ProductManagerBloc>().add(
          FetchProductsByCategoryEvent(
            category: widget.category,
            limit: 5,
            fetched: fetchedProduct,
          ),
        );

    setState(() {
      _isLoading = false;
    });
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
    ref.invalidate(categoryProductProvider);

    if(widget.category != const HomeCategoryContent.all().name){
      fetchProductsByCategory();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {

    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = ref.watch(generalProductProvider);
    final categoryProduct = ref.watch(categoryProductProvider);

    return BlocConsumer<ProductManagerBloc, ProductManagerState>(
      listener: (context, state) {
        if (state is FetchedProductByCategory) {
          log('Category product fetched');

          for(var i = 0; i< state.products.length; i++){
            log('${state.products[i].type}: Name: ${state.products[i].name}');

          }
          final products = <ProductModel>[];

          for (final element in state.products) {
            products.add(element as ProductModel);
          }
          if(products.isNotEmpty){
            ref.read(categoryProductProvider.notifier).addNewProduct(
             newProductModel: products,
            );
          }

          // context.read<ProductManagerBloc>().add(
          //   SetGeneralProductEvent(
          //     setProductType: SetProductType.insertNew,
          //     productObject: products,
          //   ),
          // );
        }

        if (state is ProductManagerFailure) {
          log('An error occurred: ${state.message}');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: HBMTextWidget(
              data: widget.category,
            ),
          ),
          body: SafeArea(
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: context.height * 0.06),
                          child: ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.width * 0.05,
                                    vertical: context.height * 0.01),
                                child: GestureDetector(
                                  onTap:(){
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productDetails,
                                      arguments: widget.category ==
                                          const HomeCategoryContent.all().name
                                          ? allProducts[index]
                                          : categoryProduct[index],
                                    );
                                  },
                                  child: Hero(
                                    tag: index,
                                    child: ProductListingWidget(
                                      product: widget.category ==
                                          const HomeCategoryContent.all().name
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
                            itemCount: widget.category ==
                                   const HomeCategoryContent.all().name
                                ? allProducts.length
                                : categoryProduct.length,
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
          ),
        );
      },
    );
  }
}
