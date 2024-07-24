part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class OrderError extends OrderState {
  const OrderError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class OrderLoading extends OrderState {}

class OrderCreated extends OrderState {
  const OrderCreated(this.order);

  final OrderEntity order;

  @override
  List<OrderEntity> get props => [order];
}

class OrderDeleted extends OrderState {}

class OrderFetched extends OrderState {
  const OrderFetched(this.order);

  final OrderEntity order;

  @override
  List<OrderEntity> get props => [order];
}

class MarkedOrderItemAsDelivered extends OrderState {
  const MarkedOrderItemAsDelivered(this.order);

  final OrderEntity order;

  @override
  List<OrderEntity> get props => [order];
}
