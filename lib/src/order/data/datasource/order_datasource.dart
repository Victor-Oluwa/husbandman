import 'package:husbandman/src/order/data/model/order_model.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';

abstract class OrderDatasource{
  Future<OrderModel> createOrder({
    required OrderEntity order,
  });

  Future<OrderModel> fetchOrder({
    required String userId,
  });

  Future<OrderModel> markOrderItemAsDelivered({
    required String orderItemId,
  });

  Future<void> deleteOrder({
    required String orderId,
  });
}
