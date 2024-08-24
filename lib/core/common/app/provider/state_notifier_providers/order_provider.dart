import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, OrderEntity>(
  (ref) => OrderNotifier(),
);

class OrderNotifier extends StateNotifier<OrderEntity> {
  OrderNotifier() : super(OrderEntity.empty);

  void updateOrder(OrderEntity order) {
    state = order;
    return;
  }
}
