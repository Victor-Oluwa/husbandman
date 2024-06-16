import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartModel>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<CartModel> {
  CartNotifier() : super(CartModel.empty());

  void updateCart({
    DataMap? newCartMap,
    CartModel? newCartModel,
  }) {

    if (newCartModel != null) {
      state = newCartModel;
      return;
    }

    if (newCartMap != null) {
      state = CartModel.fromMap(newCartMap);
      return;
    }
    return;
  }

  void removeCartItem({
    CartItem? pScapegoat,
    DataMap? mScapeGoat,
  }) {
    if (pScapegoat != null) {
      final index = state.items.indexOf(pScapegoat);
      if (index != -1) {
        state.items.removeAt(index);
      }
      return;
    }

    if (mScapeGoat != null) {
      final scapegoat = CartItem.fromMap(mScapeGoat);
      final index = state.items.indexOf(scapegoat);
      if (index != -1) {
        state.items.removeAt(index);
      }
      return;
    }
    return;
  }

  void replaceCart({
    CartItem? pNewItem,
    DataMap? mNewItem,
  }) {
    if (pNewItem != null) {
      final index = state.items.indexWhere(
        (cartItem) => cartItem.productId == pNewItem.productId,
      );

      if (index != -1) {
        state.items
          ..removeAt(index)
          ..insert(index, pNewItem);
      }
      return;
    }

    if (mNewItem != null) {
      final item = CartItem.fromMap(mNewItem);
      final index = state.items.indexWhere(
        (cartItem) => cartItem.productId == item.productId,
      );

      if (index != -1) {
        state.items
          ..removeAt(index)
          ..insert(index, item);
      }
      return;
    }
    return;
  }
}
