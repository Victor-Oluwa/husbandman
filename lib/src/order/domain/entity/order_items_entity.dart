import 'package:equatable/equatable.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';

class OrderItemsEntity extends Equatable {
  const OrderItemsEntity({
    required this.itemName,
    required this.itemImage,
    required this.itemDescription,
    required this.itemPrice,
    required this.isItemDelivered,
    required this.deductible,
    required this.itemQuantity,
    this.id = '',

  });

  factory OrderItemsEntity.fromMap(Map<String, dynamic> map) {
    return OrderItemsEntity(
      id: map['_id'] as String? ?? '',
      itemName: map['itemName'] as String? ?? '',
      itemImage: map['itemImage'] as String? ?? '',
      itemDescription: map['itemDescription'] as String? ?? '',
      itemPrice: (map['itemPrice'] as num?)?.toDouble() ?? 0,
      isItemDelivered: map['isItemDelivered'] as bool? ?? false,
      deductible: (map['deductible'] as num?)?.toDouble() ?? 0,
      itemQuantity: map['itemQuantity'] as int? ?? 0,
    );
  }

  factory OrderItemsEntity.fromCartItem(CartItemEntity cartItem) {
    return OrderItemsEntity(
      itemName: cartItem.productName,
      itemImage: cartItem.productImage,
      itemDescription: '',
      itemPrice: cartItem.productPrice,
      isItemDelivered: false,
      deductible: cartItem.percentage,
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
    deductible: 0,
    itemQuantity: 0,
  );

  final String id;
  final String itemName;
  final String itemImage;
  final String itemDescription;
  final double itemPrice;
  final bool isItemDelivered;
  final double deductible;
  final int itemQuantity;

  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'itemImage': itemImage,
      'itemDescription': itemDescription,
      'itemPrice': itemPrice,
      'isItemDelivered': isItemDelivered,
      'deductible': deductible,
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
    deductible,
    itemQuantity,
  ];
}
