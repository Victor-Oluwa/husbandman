import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/data/model/cart_item.dart';
import 'package:husbandman/src/order/data/model/all_orders_model.dart';
import 'package:husbandman/src/order/data/model/order_items_model.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel extends OrderEntity {
  const OrderModel({
    required super.ownerId,
    required super.grandTotal,
    required List<AllOrdersModel> super.orders,
    super.id,
  });

  factory OrderModel.fromCart({
    required String ownerId,
    required List<CartItem> cartItems,
    required String orderName,
  }) {
    final orderItems = cartItems.map(OrderItemsModel.fromCartItem).toList();

    final allOrdersModel = AllOrdersModel(
      grossTotal: orderItems.fold(
        0,
        (sum, item) => sum + item.itemPrice * item.itemQuantity,
      ),
      orderName: orderName,
      totalPercentage: orderItems.fold(
        0,
        (sum, item) => sum + item.deductible * item.itemQuantity,
      ),
      orderItems: orderItems,
    );

    return OrderModel(
      ownerId: ownerId,
      grandTotal: allOrdersModel.grossTotal,
      orders: [allOrdersModel],
    );
  }

  factory OrderModel.fromJson(DataMap json) => _$OrderModelFromJson(json);

  @override
  DataMap toJson() => _$OrderModelToJson(this);

  static const empty = OrderModel(
    id: 'id',
    ownerId: 'ownerId',
    grandTotal: 0,
    orders: [AllOrdersModel.empty],
  );

  @override
  List<Object?> get props => [id, ownerId, grandTotal, orders];
}
