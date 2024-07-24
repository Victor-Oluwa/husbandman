part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();
}

class CreateOrderEvent extends OrderEvent {
  const CreateOrderEvent(this.order);

  final OrderEntity order;

  @override
  List<OrderEntity> get props => [order];
}

class DeleteOrderEvent extends OrderEvent {
  const DeleteOrderEvent(this.orderId);

  final String orderId;

  @override
  List<String> get props => [orderId];
}

class FetchOrderEvent extends OrderEvent {
  const FetchOrderEvent(this.userId);

  final String userId;

  @override
  List<String> get props => [userId];
}

class MarkOrderItemAsDeliveredEvent extends OrderEvent {
  const MarkOrderItemAsDeliveredEvent(this.orderItemId);

  final String orderItemId;

  @override
  List<String> get props => [orderItemId];
}
