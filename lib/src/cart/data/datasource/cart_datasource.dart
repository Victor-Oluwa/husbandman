import 'package:husbandman/core/common/app/entities/cart_entity.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/utils/typedef.dart';

abstract class CartDatasource{

  Future<void> setCart({
    required SetCartType setCartType,
    CartItem? pNewCartItem,
    DataMap? mNewCartItem,
    CartModel? pNewCartModel,
  });

  Future<CartEntity> updateItemQuantity({
    required int quantity,
    required String itemId,
    required String ownerId,
  });

  Future<CartEntity> deleteCartItem({
    required String ownerId,
    required String itemId,
  });

  Future<void> deleteCart({required String ownerId});

  Future<CartModel> fetchCart({required String ownerId});

}
