import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/data/datasource/order_datasource.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';
import 'package:husbandman/src/order/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  OrderRepoImpl({required OrderDatasource datasource})
      : _datasource = datasource;

  final OrderDatasource _datasource;

  @override
  ResultFuture<OrderEntity> createOrder({required OrderEntity order}) async {
    try {
      final result = await _datasource.createOrder(order: order);
      return Right(result);
    } on OrderException catch (e) {
      return Left(OrderFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteOrder({required String orderId}) async {
    try {
      final result = await _datasource.deleteOrder(orderId: orderId);
      return Right(result);
    } on OrderException catch (e) {
      return Left(OrderFailure.fromException(e));
    }
  }

  @override
  ResultFuture<OrderEntity> fetchOrder({required String userId}) async {
    try {
      final result = await _datasource.fetchOrder(userId: userId);
      return Right(result);
    } on OrderException catch (e) {
      return Left(OrderFailure.fromException(e));
    }
  }

  @override
  ResultFuture<OrderEntity> markOrderItemAsDelivered(
      {required String orderItemId,}) async {
    try {
      final result =
          await _datasource.markOrderItemAsDelivered(orderItemId: orderItemId);
      return Right(result);
    } on OrderException catch (e) {
      return Left(OrderFailure.fromException(e));
    }
  }
}
