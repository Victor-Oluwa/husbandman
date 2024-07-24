import 'package:equatable/equatable.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';

class OrderItemsEntity extends Equatable {
  const OrderItemsEntity({

    required this.id,
    required this.itemName,
    required this.itemImage,
    required this.itemDescription,
    required this.itemPrice,
    required this.isItemDelivered,
    required this.itemPercentage,
    required this.itemQuantity,
  });

  factory OrderItemsEntity.fromMap(Map<String, dynamic> map) {
    return OrderItemsEntity(
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

  factory OrderItemsEntity.fromCartItem(CartItemEntity cartItem) {
    return OrderItemsEntity(
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

  static const empty = OrderItemsEntity(
    id: '',
    itemName: '',
    itemImage: '',
    itemDescription: '',
    itemPrice: 0,
    isItemDelivered: false,
    itemPercentage: 0,
    itemQuantity: 0,
  );

  final String id;
  final String itemName;
  final String itemImage;
  final String itemDescription;
  final double itemPrice;
  final bool isItemDelivered;
  final double itemPercentage;
  final int itemQuantity;

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
