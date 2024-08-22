import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_items_entity.g.dart';

@JsonSerializable()
class OrderItemsEntity extends Equatable {
  const OrderItemsEntity({
    required this.buyerId,
    required this.sellerId,
    required this.sellerName,
    required this.itemId,
    required this.itemName,
    required this.itemImage,
    required this.itemDescription,
    required this.itemPrice,
    required this.isItemDelivered,
    required this.itemDeliveryDate,
    required this.deductible,
    required this.itemQuantity,
    this.id = '',

  });

  factory OrderItemsEntity.fromCartItem(CartItemEntity cartItem) {
    return OrderItemsEntity(
      sellerId: cartItem.sellerId,
      sellerName: cartItem.sellerName,
      buyerId: cartItem.buyerId,
      itemId: cartItem.productId,
      itemName: cartItem.productName,
      itemImage: cartItem.productImage,
      itemDescription: '',
      itemPrice: cartItem.productPrice,
      isItemDelivered: false,
      itemDeliveryDate: cartItem.deliveryDate,
      deductible: cartItem.percentage,
      itemQuantity: cartItem.productQuantity,
    );
  }

  factory OrderItemsEntity.fromJson(DataMap json)=>_$OrderItemsEntityFromJson(json);
  DataMap toJson() => _$OrderItemsEntityToJson(this);

  static const empty = OrderItemsEntity(
    buyerId: '',
    sellerId: '',
    sellerName: '',
    itemId: '',
    itemName: '',
    itemImage: '',
    itemDescription: '',
    itemPrice: 0,
    isItemDelivered: false,
    itemDeliveryDate: '',
    deductible: 0,
    itemQuantity: 0,
  );

  @JsonKey(name: '_id')
  final String id;
  final String buyerId;
  final String sellerId;
  final String sellerName;
  final String itemId;
  final String itemName;
  final String itemImage;
  final String itemDescription;
  final String itemDeliveryDate;
  final double itemPrice;
  final bool isItemDelivered;
  final double deductible;
  final int itemQuantity;

  @override
  List<Object?> get props => [
    id,
    itemId,
    itemName,
    itemImage,
    buyerId,
    sellerId,
    sellerName,
    itemDescription,
    itemPrice,
    isItemDelivered,
    itemDeliveryDate,
    deductible,
    itemQuantity,
  ];
}
