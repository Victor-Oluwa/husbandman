import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:husbandman/src/order/domain/entity/order_items_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_items_model.g.dart';

@JsonSerializable()
class OrderItemsModel extends OrderItemsEntity {
  const OrderItemsModel({
    required super.itemId,
    required super.itemName,
    required super.itemImage,
    required super.itemDescription,
    required super.itemPrice,
    required super.buyerId,
    required super.sellerId,
    required super.sellerName,
    required super.itemDeliveryDate,
    required super.isItemDelivered,
    required super.deductible,
    required super.itemQuantity,
    super.id = '',
  });

  factory OrderItemsModel.fromCartItem(CartItemEntity cartItem) {
    return OrderItemsModel(
      itemId: cartItem.productId,
      itemName: cartItem.productName,
      itemImage: cartItem.productImage,
      itemDescription: '',
      itemPrice: cartItem.productPrice,
      sellerId: cartItem.sellerId,
      sellerName: cartItem.sellerName,
      buyerId: cartItem.buyerId,
      itemDeliveryDate: cartItem.deliveryDate,
      isItemDelivered: false,
      deductible: cartItem.percentage,
      itemQuantity: cartItem.productQuantity,
    );
  }

  factory OrderItemsModel.fromJson(DataMap json) =>
      _$OrderItemsModelFromJson(json);

  @override
  DataMap toJson() => _$OrderItemsModelToJson(this);

  static const empty = OrderItemsModel(
    itemId: '',
    itemName: '',
    itemImage: '',
    itemDescription: '',
    itemPrice: 0,
    isItemDelivered: false,
    deductible: 0,
    itemQuantity: 0,
    sellerId: '',
    sellerName:'',
    buyerId: '',
    itemDeliveryDate: '',
  );

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
