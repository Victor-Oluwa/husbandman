import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

final generalProductProvider =
StateNotifierProvider<GeneralProductNotifier, List<ProductModel>>(
      (ref) => GeneralProductNotifier(),
);

class GeneralProductNotifier extends StateNotifier<List<ProductModel>> {
  GeneralProductNotifier() : super(<ProductModel>[]);

  void addNewProduct({
    List<DataMap>? newProductMap,
    List<ProductModel>? newProductModel,
  }) {
    if (newProductModel != null) {
      state.addAll(newProductModel);
      return;
    }

    if (newProductMap != null) {
      final products = <ProductModel>[];

      for (final element in newProductMap) {
        final newProduct = ProductModel.fromJson(element);
        products.add(newProduct);
      }
      state.addAll(products);
      log('Provider length: ${state.length}');
      return;
    }
    return;
  }

  void removeProduct({
    List<ProductModel>? pScapegoat,
    List<DataMap>? mScapeGoat,
  }) {
    if (pScapegoat != null) {
      final index = state.indexOf(pScapegoat.first);
      if (index != -1) {
        state.removeAt(index);
      }
      return;
    }

    if (mScapeGoat != null) {
      final scapegoat = ProductModel.fromJson(mScapeGoat.first);
      final index = state.indexOf(scapegoat);
      if (index != -1) {
        state.removeAt(index);
      }
      return;
    }
    return;
  }

  void replaceProduct({
    List<ProductModel>? pNewProduct,
    List<DataMap>? mNewProduct,
  }) {
    if (pNewProduct != null) {
      final index =
      state.indexWhere((product) => product.id == pNewProduct.first.id);

      if (index != -1) {
        state
          ..removeAt(index)
          ..insert(index, pNewProduct.first);
      }
      return;
    }

    if (mNewProduct != null) {
      final newProduct = ProductModel.fromJson(mNewProduct.first);
      final index = state.indexWhere((product) => product.id == newProduct.id);

      if (index != -1) {
        state
          ..removeAt(index)
          ..insert(index, newProduct);
      }
      return;
    }
    return;
  }

  void renewList({
    List<ProductModel>? pProductList,
    List<DataMap>? mProductList,
  }) {
    if (pProductList != null) {
      state = pProductList;
      return;
    }

    if (mProductList != null) {
      state =
          List<DataMap>.from(mProductList).map(ProductModel.fromJson).toList();
      return;
    }

    return;
  }
}
