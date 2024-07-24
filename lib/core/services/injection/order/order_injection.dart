import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/services/injection/injection_container.dart';
import 'package:husbandman/src/order/data/datasource/order_datasource.dart';
import 'package:husbandman/src/order/data/datasource/order_datasource_impl.dart';
import 'package:husbandman/src/order/data/repo/order_repo_impl.dart';
import 'package:husbandman/src/order/domain/repo/order_repo.dart';
import 'package:husbandman/src/order/domain/usecases/create_order.dart';
import 'package:husbandman/src/order/domain/usecases/delete_order.dart';
import 'package:husbandman/src/order/domain/usecases/fetch_order.dart';
import 'package:husbandman/src/order/domain/usecases/mark_order_items_as_delivered.dart';
import 'package:husbandman/src/order/presentation/bloc/order_bloc.dart';

final orderBlocProvider = Provider.autoDispose<OrderBloc>((ref) {
  return OrderBloc(
    ref.read(createOrderProvider),
    ref.read(deleteOrderProvider),
    ref.read(fetchOrderProvider),
    ref.read(markOrderItemAsDelivered),
  );
});

final orderDatasourceProvider = Provider.autoDispose<OrderDatasource>(
  (ref) => OrderDatasourceImpl(
    dio: ref.read(dioProvider),
  ),
);

final orderRepoProvider = Provider.autoDispose<OrderRepo>(
  (ref) => OrderRepoImpl(
    datasource: ref.read(orderDatasourceProvider),
  ),
);

final createOrderProvider = Provider.autoDispose<CreateOrder>(
  (ref) => CreateOrder(
    orderRepo: ref.read(orderRepoProvider),
  ),
);

final deleteOrderProvider = Provider.autoDispose<DeleteOrder>(
  (ref) => DeleteOrder(
    orderRepo: ref.read(orderRepoProvider),
  ),
);

final fetchOrderProvider = Provider.autoDispose<FetchOrder>(
  (ref) => FetchOrder(
    orderRepo: ref.read(orderRepoProvider),
  ),
);

final markOrderItemAsDelivered =
    Provider.autoDispose<MarkOrderItemsAsDelivered>(
  (ref) => MarkOrderItemsAsDelivered(
    orderRepo: ref.read(orderRepoProvider),
  ),
);
