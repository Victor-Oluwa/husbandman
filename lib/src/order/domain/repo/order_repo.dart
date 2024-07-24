import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';

abstract class OrderRepo {
  ResultFuture<OrderEntity> createOrder({
    required OrderEntity order,
  });

  ResultFuture<OrderEntity> fetchOrder({
    required String userId,
  });

  ResultFuture<OrderEntity> markOrderItemAsDelivered({
    required String orderItemId,
  });

  ResultFuture<void> deleteOrder({
    required String orderId,
  });
}
