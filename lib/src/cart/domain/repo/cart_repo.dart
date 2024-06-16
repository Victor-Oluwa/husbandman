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

  ResultFuture<CartItem> updateItemQuantity({
    required int quantity,
    required String itemId,
    required String ownerId,
  });

  ResultFuture<void> deleteCartItem({
    required String ownerId,
    required String itemId,
  });

  ResultFuture<void> deleteCart({required String ownerId});

  ResultFuture<CartModel> fetchCart({required String ownerId});

}
