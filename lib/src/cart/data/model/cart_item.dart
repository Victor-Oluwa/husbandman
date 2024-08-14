import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem extends CartItemEntity {
  const CartItem({
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.productQuantity,
    required super.sellerName,
    required super.sellerId,
    required super.buyerId,
    required super.deliveryDate,
    required super.percentage,
    super.id,
  });

  const CartItem.empty()
      : this(
          id: '',
          deliveryDate: '',
          productId: '',
          productName: '',
          productPrice: 0,
          productQuantity: 0,
          sellerId: '',
          buyerId: '',
          sellerName: '',
          productImage: '',
          percentage: 0,
        );

  factory CartItem.fromJson(DataMap json) => _$CartItemFromJson(json);

  DataMap toMap() => _$CartItemToJson(this);

  @override
  List<dynamic> get props => [
        id,
        productId,
        productName,
        productImage,
        productPrice,
        productQuantity,
        sellerName,
        sellerId,
        deliveryDate,
        percentage,
      ];
}
