import 'package:husbandman/core/common/app/entities/cart_entity.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/utils/typedef.dart';

abstract class CartRepo {

  ResultFuture<void> setCart({
    required SetCartType setCartType,
    CartItem? pNewCartItem,
    DataMap? mNewCartItem,
    CartModel? pNewCartModel,
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
