// import 'package:equatable/equatable.dart';
// import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
//
// class OrderEntity extends Equatable {
//   const OrderEntity({
//     required this.id,
//     required this.ownerId,
//     required this.grandTotal,
//     required this.orders,
//   });
//
//   const OrderEntity.empty()
//       : this(
//           id: 'id',
//           ownerId: 'ownerId',
//           grandTotal: 0,
//           orders: const [OrdersEntity.empty()],
//         );
//
//   final String id;
//   final String ownerId;
//   final double grandTotal;
//   final List<OrdersEntity> orders;
//
//   @override
//   List<Object?> get props => [id, ownerId, grandTotal, orders];
// }
//
// class OrdersEntity extends Equatable {
//   const OrdersEntity({
//     required this.id,
//     required this.grossTotal,
//     required this.orderName,
//     required this.orderItems,
//   });
//
//   const OrdersEntity.empty()
//       : this(
//           id: '',
//           grossTotal: 0,
//           orderItems: const [],
//           orderName: '',
//         );
//
//   final String id;
//   final double grossTotal;
//   final String orderName;
//   final List<OrderItems> orderItems;
//
//   @override
//   List<Object?> get props => [id, grossTotal, orderName, orderItems];
// }
//
// class OrderItems {
//   OrderItems({
//     required this.itemName,
//     required this.itemImage,
//     required this.itemDescription,
//     required this.itemPrice,
//     required this.isItemDelivered,
//     required this.itemPercentage,
//     required this.itemQuantity,
//   });
//
//   OrderItems.empty()
//       : this(
//           itemName: '',
//           itemImage: '',
//           itemDescription: '',
//           itemPrice: 0,
//           isItemDelivered: false,
//           itemPercentage: 0,
//           itemQuantity: 0,
//         );
//
//   final String itemName;
//   final String itemImage;
//   final String itemDescription;
//   final double itemPrice;
//   final bool isItemDelivered;
//   final double itemPercentage;
//   final int itemQuantity;
// }
//
// final cart = CartEntity.empty().items;
//
// double grandTotal = 0;
// double grossTotal = 0;
//
// final orderItemsList = <OrderItems>[];
//
// void function() {
//   for (var i = 0; i <= cart.length; i++) {
//     final orderItems = OrderItems(
//       itemName: cart[i].productName,
//       itemImage: cart[i].productImage,
//       itemDescription: '',
//       itemPrice: cart[i].productPrice,
//       isItemDelivered: false,
//       itemPercentage: cart[i].percentage,
//       itemQuantity: cart[i].productQuantity,
//     );
//     orderItemsList.add(orderItems);
//   }
// }
//
// final orderOrders = [
//   OrdersEntity(
//       id: 'id', grossTotal: 0, orderName: 'orderName', orderItems: orderItemsList,)
// ];
// final newOrder = OrderEntity(
//     id: 'id', ownerId: 'ownerId', grandTotal: 0, orders: orderOrders,);

import 'package:equatable/equatable.dart';
import 'package:husbandman/src/cart/data/model/cart_item.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:husbandman/src/order/domain/entity/all_orders_entity.dart';
import 'package:husbandman/src/order/domain/entity/order_items_entity.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.ownerId,
    required this.grandTotal,
    required this.orders,
    this.id = '',
  });

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['_id'] as String? ?? '',
      ownerId: map['ownerId'] as String? ?? '',
      grandTotal: (map['grandTotal'] as num?)?.toDouble() ?? 0.0,
      orders: (map['orders'] as List<dynamic>?)
              ?.map(
                (item) => AllOrdersEntity.fromMap(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  factory OrderEntity.fromCart({
    required String ownerId,
    required List<CartItemEntity> cartItems,
    required String orderName,
  }) {
    final orderItems =
        cartItems.map((item) => OrderItemsEntity.fromCartItem(item)).toList();

    final allOrdersEntity = AllOrdersEntity(
      grossTotal: orderItems.fold(
          0, (sum, item) => sum + item.itemPrice * item.itemQuantity),
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

  static const empty = OrderEntity(
    id: 'id',
    ownerId: 'ownerId',
    grandTotal: 0,
    orders: [AllOrdersEntity.empty],
  );

  final String id;
  final String ownerId;
  final double grandTotal;
  final List<AllOrdersEntity> orders;

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'grandTotal': grandTotal,
      'orders': orders.map((order) => order.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, ownerId, grandTotal, orders];
}
