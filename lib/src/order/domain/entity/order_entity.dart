
import 'package:equatable/equatable.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:husbandman/src/order/domain/entity/all_orders_entity.dart';
import 'package:husbandman/src/order/domain/entity/order_items_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderEntity extends Equatable {
  const OrderEntity({
    required this.ownerId,
    required this.grandTotal,
    required this.orders,
    this.id = '',
  });

  factory OrderEntity.fromCart({
    required String ownerId,
    required List<CartItemEntity> cartItems,
    required String orderName,
  }) {
    final orderItems =
        cartItems.map(OrderItemsEntity.fromCartItem).toList();

    final allOrdersEntity = AllOrdersEntity(
      grossTotal: orderItems.fold(
          0, (sum, item) => sum + item.itemPrice * item.itemQuantity,),
      orderName: orderName,
      totalPercentage:
          orderItems.fold(0, (sum, item) => sum + item.deductible*item.itemQuantity),
      orderItems: orderItems,
    );

    return OrderEntity(
      ownerId: ownerId,
      grandTotal: allOrdersEntity.grossTotal,
      orders: [allOrdersEntity],
    );
  }

  factory OrderEntity.fromJson(Map<String, dynamic> json) => _$OrderEntityFromJson(json);
  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);

  @JsonKey(name: '_id')
  final String id;
  final String ownerId;
  final double grandTotal;
  final List<AllOrdersEntity> orders;

  static const empty = OrderEntity(
    id: 'id',
    ownerId: 'ownerId',
    grandTotal: 0,
    orders: [AllOrdersEntity.empty],
  );

  @override
  List<Object?> get props => [id, ownerId, grandTotal, orders];
}
