import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/data/datasource/order_datasource.dart';
import 'package:husbandman/src/order/data/model/order_model.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';

const String kCreateOrderEndpoint = '/order/create-new';
const String kDeleteOrderEndpoint = '/order/orderItems/delete-one';
const String kFetchOrdersEndpoint = '/order/fetch';
const String kMarkOrderItemAsDelivered =
    'order/orderItems/mark-one-as-delivered';

class OrderDatasourceImpl implements OrderDatasource {
  OrderDatasourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<OrderModel> createOrder({required OrderEntity order}) async {
    try {
      final response = await _dio.post<DataMap>(
        '$kBaseUrl$kCreateOrderEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode(
          order.toJson(),
        ),
      );

      final responseData = response.data;

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw OrderException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (responseData == null) {
        throw const OrderException(
          message: 'CreateOrder response returned null',
          statusCode: 500,
        );
      }

      log('Create order called: none');

      final transformed = OrderModel.fromJson(responseData);
      log('Create order called: $transformed');

      return transformed;

    } on OrderException catch (_) {
      rethrow;
      } on DioException catch (e) {
        if (e.response?.data != null) {
          throw OrderException(
            message: e.response?.data.toString() ?? '',
            statusCode: 500,
          );
        } else {
          throw OrderException(
            message: e.message ?? '',
            statusCode: 500,
          );
        }
    } catch (e) {
      throw OrderException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> deleteOrder({required String orderId}) async {
    try {
      final response = await _dio
          .post<String>(
            '$kBaseUrl$kDeleteOrderEndpoint',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode({
              'orderId': orderId,
            }),
          )
          .timeout(
            const Duration(seconds: 30),
          );

      final responseData = response.data;

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw OrderException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (responseData == null) {
        throw const OrderException(
          message: 'DeleteOrder response returned null',
          statusCode: 500,
        );
      }
    } on OrderException catch (_) {
      rethrow;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw OrderException(
          message: e.response?.data.toString() ?? '',
          statusCode: 500,
        );
      } else {
        throw OrderException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw OrderException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<OrderModel> fetchOrder({required String userId}) async {
    try {
      final response = await _dio
          .post<DataMap>(
            '$kBaseUrl$kFetchOrdersEndpoint',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode(
              {'userId': userId},
            ),
          )
          .timeout(const Duration(seconds: 30));

      final responseData = response.data;

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw OrderException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (responseData == null) {
        throw const OrderException(
          message: 'FetchOrder response returned null',
          statusCode: 500,
        );
      }
      return OrderModel.fromJson(responseData);
    } on OrderException catch (_) {
      rethrow;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw OrderException(
          message: e.response?.data.toString() ?? '',
          statusCode: 500,
        );
      } else {
        throw OrderException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw OrderException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<OrderModel> markOrderItemAsDelivered({
    required String orderItemId,
  }) async {
    try {
      final response = await _dio
          .post<DataMap>(
            '$kBaseUrl$kMarkOrderItemAsDelivered',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode(
              {'orderItemId': orderItemId},
            ),
          )
          .timeout(const Duration(seconds: 30));

      final responseData = response.data;

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw OrderException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (responseData == null) {
        throw const OrderException(
          message: 'MarkOrderItemAsDelivered response returned null',
          statusCode: 500,
        );
      }
      return OrderModel.fromJson(responseData);
    } on OrderException catch (_) {
      rethrow;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw OrderException(
          message: e.response?.data.toString() ?? '',
          statusCode: 500,
        );
      } else {
        throw OrderException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw OrderException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
