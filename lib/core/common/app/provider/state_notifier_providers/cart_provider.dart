
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartEntity>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<CartEntity> {
  CartNotifier() : super(CartEntity.empty());

  void updateCart({
   required CartEntity cartEntity,
  }) {
      state = cartEntity;
      return;
  }
}
