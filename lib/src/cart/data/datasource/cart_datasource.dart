import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/src/cart/data/model/cart_model.dart';

abstract class CartDatasource{

  Future<void> setCart({
    required CartEntity cartEntity,
  });

  Future<CartModel> updateItemQuantity({
    required int quantity,
    required String itemId,
    required String ownerId,
  });

  Future<CartModel> deleteCartItem({
    required String ownerId,
    required String itemId,
  });

  Future<void> deleteCart({required String ownerId});

  Future<CartModel> fetchCart({required String ownerId});

}
