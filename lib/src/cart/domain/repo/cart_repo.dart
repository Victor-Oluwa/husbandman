import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/core/utils/typedef.dart';

abstract class CartRepo {

  ResultFuture<void> setCart({
   required CartEntity cartEntity,
  });

  ResultFuture<CartEntity> updateItemQuantity({
    required int quantity,
    required String itemId,
    required String ownerId,
  });

  ResultFuture<CartEntity> deleteCartItem({
    required String ownerId,
    required String itemId,
  });

  ResultFuture<void> deleteCart({required String ownerId});

  ResultFuture<CartEntity> fetchCart({required String ownerId});

}
