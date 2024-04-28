import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
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
      state.insert(0, newProductModel.first);
      return;
    }

    if (newProductMap != null) {
      final newProduct = ProductModel.fromMap(newProductMap.first);
      state.insert(0, newProduct);
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
      final scapegoat = ProductModel.fromMap(mScapeGoat.first);
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
      final newProduct = ProductModel.fromMap(mNewProduct.first);
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
          List<DataMap>.from(mProductList).map(ProductModel.fromMap).toList();
      return;
    }

    return;
  }
}