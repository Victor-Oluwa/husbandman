import 'dart:developer';

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

  void removeCartItem2({required int index}){
    final updatedItems = List<CartItem>.from(state.items)..removeAt(index);
    log('Carrrt: '+updatedItems.toString());
    log('index: $index');
    // Update the state with the new list
    state = state.copyWith(items: updatedItems);
  }

  void removeCartItem({
    CartItem? pScapegoat,
    DataMap? mScapeGoat,
  }) {
    if (pScapegoat != null && mScapeGoat == null) {
      final index = state.items.indexOf(pScapegoat);
      if (index != -1) {
        final updatedItems = List<CartItem>.from(state.items)..removeAt(index);
        log('Carrrt: '+updatedItems.toString());
        log('index: $index');

        // Update the state with the new list
        state = state.copyWith(items: updatedItems);
      }
      return;
    }

    if (mScapeGoat != null && pScapegoat == null) {
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
