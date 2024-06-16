import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/data/datasource/cart_datasource.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  CartRepoImpl({required CartDatasource cartDatasource})
      : _cartDatasource = cartDatasource;

  final CartDatasource _cartDatasource;

  @override
  ResultFuture<void> deleteCart({required String ownerId}) async {
    try {
      final result = await _cartDatasource.deleteCart(
        ownerId: ownerId,
      );
      return Right(result);
    } on CartException catch (e) {
      return Left(CartFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteCartItem({
    required String ownerId,
    required String itemId,
  }) async {
    try {
      final result = await _cartDatasource.deleteCart(ownerId: ownerId);
      return Right(result);
    } on CartException catch (e) {
      return Left(CartFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> setCart({
    required SetCartType setCartType,
    CartItem? pNewCartItem,
    DataMap? mNewCartItem,
    CartModel? pNewCartModel,
  }) async {
    try {
      final result = await _cartDatasource.setCart(
        setCartType: setCartType,
        mNewCartItem: mNewCartItem,
        pNewCartItem: pNewCartItem,
        pNewCartModel: pNewCartModel,
      );
      return Right(result);
    } on CartException catch (e) {
      return Left(CartFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CartItem> updateItemQuantity({
    required int quantity,
    required String itemId,
    required String ownerId,
  }) async {
    try {
      final result = await _cartDatasource.updateItemQuantity(
        quantity: quantity,
        itemId: itemId,
        ownerId: ownerId,
      );
      return Right(result);
    } on CartException catch (e) {
      return Left(CartFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CartModel> fetchCart({required String ownerId}) async {
    try {
      final result = await _cartDatasource.fetchCart(ownerId: ownerId);
      return Right(result);
    } on CartException catch (e) {
      return Left(CartFailure.fromException(e));
    }
  }
}
