import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:husbandman/src/order/domain/entity/order_items_entity.dart';

class OrderItemsModel extends OrderItemsEntity {
  const OrderItemsModel({
    required super.id,
    required super.itemName,
    required super.itemImage,
    required super.itemDescription,
    required super.itemPrice,
    required super.isItemDelivered,
    required super.itemPercentage,
    required super.itemQuantity,
  });

  factory OrderItemsModel.fromMap(Map<String, dynamic> map) {
    return OrderItemsModel(
      id: map['_id'] as String? ?? '',
      itemName: map['itemName'] as String? ?? '',
      itemImage: map['itemImage'] as String? ?? '',
      itemDescription: map['itemDescription'] as String? ?? '',
      itemPrice: (map['itemPrice'] as num?)?.toDouble() ?? 0,
      isItemDelivered: map['isItemDelivered'] as bool? ?? false,
      itemPercentage: (map['itemPercentage'] as num?)?.toDouble() ?? 0,
      itemQuantity: map['itemQuantity'] as int? ?? 0,
    );
  }

  factory OrderItemsModel.fromCartItem(CartItemEntity cartItem) {
    return OrderItemsModel(
      id: '',
      itemName: cartItem.productName,
      itemImage: cartItem.productImage,
      itemDescription: '',
      itemPrice: cartItem.productPrice,
      isItemDelivered: false,
      itemPercentage: cartItem.percentage,
      itemQuantity: cartItem.productQuantity,
    );
  }

  static const empty = OrderItemsModel(
    id: '',
    itemName: '',
    itemImage: '',
    itemDescription: '',
    itemPrice: 0,
    isItemDelivered: false,
    itemPercentage: 0,
    itemQuantity: 0,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'itemName': itemName,
      'itemImage': itemImage,
      'itemDescription': itemDescription,
      'itemPrice': itemPrice,
      'isItemDelivered': isItemDelivered,
      'itemPercentage': itemPercentage,
      'itemQuantity': itemQuantity,
    };
  }

  @override
  List<Object?> get props => [
    id,
        itemName,
        itemImage,
        itemDescription,
        itemPrice,
        isItemDelivered,
        itemPercentage,
        itemQuantity,
      ];
}
