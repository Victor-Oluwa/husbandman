import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

final sellerProductProvider =
    StateNotifierProvider<SellerProductNotifier, List<ProductModel>>(
  (ref) => SellerProductNotifier(),
);

class SellerProductNotifier extends StateNotifier<List<ProductModel>> {
  SellerProductNotifier() : super(<ProductModel>[]);

  ProductModel addNewProduct({
    List<DataMap>? newProductMap,
    List<ProductModel>? newProductModel,
  }) {
    if (newProductModel != null) {
      state.insert(0, newProductModel.first);
      return state.first;
    }

    if (newProductMap != null) {
      final newProduct = ProductModel.fromJson(newProductMap.first);
      state.insert(0, newProduct);
      return state.first;
    }
    return state.first;
  }

  ProductModel removeProduct({
    List<ProductModel>? pScapegoat,
    List<DataMap>? mScapeGoat,
  }) {
    if (pScapegoat != null) {
      final index = state.indexOf(pScapegoat.first);
      if (index != -1) {
        state.removeAt(index);
      }
      return state.first;
    }

    if (mScapeGoat != null) {
      final scapegoat = ProductModel.fromJson(mScapeGoat.first);
      final index = state.indexOf(scapegoat);
      if (index != -1) {
        state.removeAt(index);
      }
      return state.first;
    }
    return state.first;
  }

  ProductModel replaceProduct({
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
      return state.first;
    }

    if (mNewProduct != null) {
      final newProduct = ProductModel.fromJson(mNewProduct.first);
      final index = state.indexWhere((product) => product.id == newProduct.id);

      if (index != -1) {
        state
          ..removeAt(index)
          ..insert(index, newProduct);
      }
      return state.first;
    }
    return state.first;
  }

  ProductModel renewList({
    List<ProductModel>? pProductList,
    List<DataMap>? mProductList,
  }) {
    if (pProductList != null) {
      state = pProductList;
      return state.first;
    }

    if (mProductList != null) {
      state =
          List<DataMap>.from(mProductList).map(ProductModel.fromJson).toList();
      return state.first;
    }

    return state.first;
  }
}
