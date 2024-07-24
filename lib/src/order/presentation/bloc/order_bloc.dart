import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';
import 'package:husbandman/src/order/domain/usecases/create_order.dart';
import 'package:husbandman/src/order/domain/usecases/delete_order.dart';
import 'package:husbandman/src/order/domain/usecases/fetch_order.dart';
import 'package:husbandman/src/order/domain/usecases/mark_order_items_as_delivered.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(
    CreateOrder createOrder,
    DeleteOrder deleteOrder,
    FetchOrder fetchOrder,
    MarkOrderItemsAsDelivered markOrderItemAsDelivered,
  )   : _createOrder = createOrder,
        _deleteOrder = deleteOrder,
        _fetchOrder = fetchOrder,
        _markOrderItemsAsDelivered = markOrderItemAsDelivered,
        super(OrderInitial()) {
    on<OrderEvent>((event, emit) {
      emit(OrderLoading());
    });
    on<CreateOrderEvent>(_createOrderEventHandler);
    on<DeleteOrderEvent>(_deleteOrderEventHandler);
    on<FetchOrderEvent>(_fetchOrderEventHandler);
    on<MarkOrderItemAsDeliveredEvent>(_markOrderItemAsDeliveredEventHandler);
  }

  final CreateOrder _createOrder;
  final DeleteOrder _deleteOrder;
  final FetchOrder _fetchOrder;
  final MarkOrderItemsAsDelivered _markOrderItemsAsDelivered;

  Future<void> _createOrderEventHandler(
    CreateOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _createOrder(event.order);

    result.fold(
      (l) => emit(OrderError(l.errorMessage)),
      (r) => emit(
        OrderCreated(r),
      ),
    );
  }

  Future<void> _deleteOrderEventHandler(
    DeleteOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _deleteOrder(event.orderId);

    result.fold(
      (l) => emit(OrderError(l.errorMessage)),
      (r) => emit(
        OrderDeleted(),
      ),
    );
  }

  Future<void> _fetchOrderEventHandler(
    FetchOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _fetchOrder(event.userId);

    result.fold(
      (l) => emit(OrderError(l.errorMessage)),
      (r) => emit(OrderFetched(r)),
    );
  }

  Future<void> _markOrderItemAsDeliveredEventHandler(
    MarkOrderItemAsDeliveredEvent event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _markOrderItemsAsDelivered(event.orderItemId);

    result.fold(
      (l) => emit(OrderError(l.errorMessage)),
      (r) => emit(
        MarkedOrderItemAsDelivered(r),
      ),
    );
  }
}
