// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemEntity _$CartItemEntityFromJson(Map<String, dynamic> json) =>
    CartItemEntity(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      productQuantity: (json['productQuantity'] as num).toInt(),
      sellerName: json['sellerName'] as String,
      sellerId: json['sellerId'] as String,
      buyerId: json['buyerId'] as String,
      deliveryDate: json['deliveryDate'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$CartItemEntityToJson(CartItemEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'productImage': instance.productImage,
      'productPrice': instance.productPrice,
      'productQuantity': instance.productQuantity,
      'sellerName': instance.sellerName,
      'sellerId': instance.sellerId,
      'deliveryDate': instance.deliveryDate,
      'percentage': instance.percentage,
      'buyerId': instance.buyerId,
    };
