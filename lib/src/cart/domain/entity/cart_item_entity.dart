import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_entity.g.dart';

@JsonSerializable()
class CartItemEntity extends Equatable {
  const CartItemEntity({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.sellerName,
    required this.sellerId,
    required this.buyerId,
    required this.deliveryDate,
    required this.percentage,
    this.id = '',
  });

  const CartItemEntity.empty()
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

  factory CartItemEntity.fromJson(DataMap json) =>
      _$CartItemEntityFromJson(json);

  DataMap toJson() => _$CartItemEntityToJson(this);

  @JsonKey(name: '_id')
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final int productQuantity;
  final String sellerName;
  final String sellerId;
  final String deliveryDate;
  final double percentage;
  final String buyerId;

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
