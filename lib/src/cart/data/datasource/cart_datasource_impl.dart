import 'dart:convert';
import 'dart:developer';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/common/app/provider/cart_provider.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/data/datasource/cart_datasource.dart';

const kUpdateProductEndpoint = '/cart/update';
const kDeleteCartItemEndpoint = '/cart/items/deleteOne';
const kDeleteCartEndpoint = '/cart/delete';
const kFetchCartEndpoint = '/cart/fetch-all';

class CartDatasourceImpl implements CartDatasource {
  CartDatasourceImpl({required Ref ref}) : _ref = ref;

  final Ref _ref;

  @override
  Future<void> deleteCart({required String ownerId}) async {
    try {
      final response = await Dio().post<DataMap>(
        '$kBaseUrl$kDeleteCartEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({'ownerId': ownerId}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw CartException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data.toString() ?? e.message;
      final statusCode = e.response?.statusCode ?? 500;
      throw CartException(
        message: errorMessage ??
            'Dio Error occurred but returned a null error message',
        statusCode: statusCode,
      );
    } on CartException catch (e) {
      log('deleteCart Error from CartDatasourceImpl class: ${e.message}');
      rethrow;
    } catch (e) {
      log('deleteCart Error from CartDatasourceImpl class: $e');
      throw CartException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<CartModel> deleteCartItem({
    required String ownerId,
    required String itemId,
  }) async {
    try {
      final response = await Dio().post<DataMap>(
        '$kBaseUrl$kDeleteCartItemEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode(
          {
            'ownerId': ownerId,
            'itemId': itemId,
          },
        ),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw CartException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      return CartModel.fromMap(response.data??{});
    } on DioException catch (e) {
      final errorMessage = e.response?.data.toString() ?? e.message;
      final statusCode = e.response?.statusCode ?? 500;
      throw CartException(
        message: errorMessage ??
            'Dio Error occurred and returned a null error message',
        statusCode: statusCode,
      );
    } on CartException catch (e) {
      log('deleteCartItem Error from CartDatasourceImpl: ${e.message}');
      rethrow;
    } catch (e) {
      log('deleteCartItem Error from CartDatasourceImpl: $e');
      throw CartException(message: e.toString(), statusCode: 300);
    }
  }

  @override
  Future<void> setCart({
    required SetCartType setCartType,
    CartItem? pNewCartItem,
    DataMap? mNewCartItem,
    CartModel? pNewCartModel,
  }) async {
    try {
      switch (setCartType) {
        case SetCartType.updateCart:
          if (pNewCartModel == null && mNewCartItem == null) {
            throw const CartException(
              message: 'Both pNewCartModel and mNewCartItem can not be null',
              statusCode: 505,
            );
          }

          if (pNewCartModel != null && mNewCartItem != null) {
            throw const CartException(
              message: 'Either pNewCartModel or mNewCartItem must be null',
              statusCode: 505,
            );
          }

          if (pNewCartModel != null && mNewCartItem == null) {
            _ref
                .read(cartProvider.notifier)
                .updateCart(newCartModel: pNewCartModel);
          }

          if (mNewCartItem != null && pNewCartModel == null) {
            _ref
                .read(cartProvider.notifier)
                .updateCart(newCartMap: mNewCartItem);
          }
          break; // Add break statement here

        case SetCartType.removeCartItem:
          if (pNewCartItem == null && mNewCartItem == null) {
            throw const CartException(
              message: 'Both pNewCartItem and mNewCartItem can not be null',
              statusCode: 505,
            );
          }

          if (pNewCartItem != null && mNewCartItem != null) {
            throw const CartException(
              message: 'Either pNewCartItem or mNewCartItem must be null',
              statusCode: 505,
            );
          }

          if (pNewCartItem != null && mNewCartItem == null) {
            _ref
                .read(cartProvider.notifier)
                .removeCartItem(pScapegoat: pNewCartItem);
          }

          if (mNewCartItem != null && pNewCartItem == null) {
            _ref
                .read(cartProvider.notifier)
                .removeCartItem(mScapeGoat: mNewCartItem);
          }
          break; // Add break statement here

        case SetCartType.replaceCart:
          if (pNewCartItem == null && mNewCartItem == null) {
            throw const CartException(
              message: 'Both pNewCartItem and mNewCartItem can not be null',
              statusCode: 505,
            );
          }

          if (pNewCartItem != null && mNewCartItem != null) {
            throw const CartException(
              message: 'Either pNewCartItem or mNewCartItem must be null',
              statusCode: 505,
            );
          }

          if (pNewCartItem != null && mNewCartItem == null) {
            _ref
                .read(cartProvider.notifier)
                .replaceCart(pNewItem: pNewCartItem);
          }

          if (mNewCartItem != null && pNewCartItem == null) {
            _ref
                .read(cartProvider.notifier)
                .replaceCart(mNewItem: mNewCartItem);
          }
          break; // Add break statement here
      }
    } on CartException catch (e) {
      log('setCart Error from CartDatasourceImpl class: ${e.message}');
      rethrow;
    } catch (e) {
      log('setCart Error from CartDatasourceImpl class: $e');
      throw CartException(message: e.toString(), statusCode: 500);
    }
  }


  @override
  Future<CartModel> updateItemQuantity({
    required int quantity,
    required String itemId,
    required String ownerId,
  }) async {
    try {
      log('passed quantity: $quantity');
      final response = await Dio().post<DataMap>(
        '$kBaseUrl$kUpdateProductEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({
          'quantity': quantity,
          'itemId': itemId,
          'ownerId': ownerId,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw CartException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }
      return CartModel.fromMap(response.data ?? {});
    } on DioException catch (e) {
      final errorMessage = e.response?.data.toString() ?? e.message;
      final statusCode = e.response?.statusCode ?? 500;
      throw CartException(
        message: errorMessage ??
            'Dio Error occurred and returned a null error message',
        statusCode: statusCode,
      );
    } on CartException catch (e) {
      log('updateItemQuantity Error from CartDatasourceImpl: ${e.message}');
      rethrow;
    } catch (e) {
      log('updateItemQuantity Error from CartDatasourceImpl: $e');
      throw CartException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<CartModel> fetchCart({required String ownerId}) async {
    try {
      final response = await Dio().post<DataMap>(
        '$kBaseUrl$kFetchCartEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({
          'ownerId': ownerId,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw CartException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (response.data == null) {
        throw const CartException(
          message: 'Cart is empty',
          statusCode: 501,
        );
      }
      // log('Cart from datasource: ${response.data}');

      return CartModel.fromMap(response.data ?? {});
    } on CartException catch (e) {
      log('fetchCart Error from CartDatasourceImpl: ${e.message}');
      rethrow;
    } on DioException catch (e) {
      final errorMessage = e.response?.data.toString() ?? e.message;
      final statusCode = e.response?.statusCode ?? 500;
      throw CartException(
        message: errorMessage ??
            'Dio Error occurred and returned a null error message',
        statusCode: statusCode,
      );
    } catch (e) {
      log('fetchCart Error from CartDatasourceImpl: $e');
      throw CartException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
