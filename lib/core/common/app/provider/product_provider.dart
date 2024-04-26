import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

final productProvider =
StateNotifierProvider<ProductNotifier, List<ProductModel>>(
      (ref) => ProductNotifier(),
);

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  ProductNotifier() : super(<ProductModel>[]);

  void addNewProduct({DataMap? newProductMap, ProductModel? newProductModel}) {
    if (newProductModel != null) {
      state.insert(0, newProductModel);
      return;
    }

    if (newProductMap != null) {
      final newProduct = ProductModel.fromMap(newProductMap);
      state.insert(0, newProduct);
      return;
    }
    return;
  }

  void removeProduct({ProductModel? pScapegoat, DataMap? mScapeGoat}) {
    if (pScapegoat != null) {
      final index = state.indexOf(pScapegoat);
      if (index != -1) {
        state.removeAt(index);
      }
      return;
    }

    if (mScapeGoat != null) {
      final scapegoat = ProductModel.fromMap(mScapeGoat);
      final index = state.indexOf(scapegoat);
      if (index != -1) {
        state.removeAt(index);
      }
      return;
    }
    return;
  }

  void replaceProduct({ProductModel? pNewProduct, DataMap? mNewProduct}) {
    if (pNewProduct != null) {
      final index = state.indexWhere((product) => product.id == pNewProduct.id);

      if (index != -1) {
        state
          ..removeAt(index)
          ..insert(index, pNewProduct);
      }
      return;
    }

    if (mNewProduct != null) {
      final newProduct = ProductModel.fromMap(mNewProduct);
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
