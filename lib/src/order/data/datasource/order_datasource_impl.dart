import 'package:husbandman/src/order/data/datasource/order_datasource.dart';
import 'package:husbandman/src/order/data/model/order_model.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';

class OrderDatasourceImpl implements OrderDatasource{
  @override
  Future<OrderModel> createOrder({required OrderEntity order}) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOrder({required String orderId}) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<OrderModel> fetchOrder({required String userId}) {
    // TODO: implement fetchOrder
    throw UnimplementedError();
  }

  @override
  Future<OrderModel> markOrderItemAsDelivered({required String orderItemId}) {
    // TODO: implement markOrderItemAsDelivered
    throw UnimplementedError();
  }
}