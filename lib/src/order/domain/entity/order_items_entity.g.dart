// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemsEntity _$OrderItemsEntityFromJson(Map<String, dynamic> json) =>
    OrderItemsEntity(
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      sellerName: json['sellerName'] as String,
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      itemImage: json['itemImage'] as String,
      itemDescription: json['itemDescription'] as String,
      itemPrice: (json['itemPrice'] as num).toDouble(),
      isItemDelivered: json['isItemDelivered'] as bool,
      itemDeliveryDate: json['itemDeliveryDate'] as String,
      deductible: (json['deductible'] as num).toDouble(),
      itemQuantity: (json['itemQuantity'] as num).toInt(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$OrderItemsEntityToJson(OrderItemsEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'sellerName': instance.sellerName,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'itemImage': instance.itemImage,
      'itemDescription': instance.itemDescription,
      'itemDeliveryDate': instance.itemDeliveryDate,
      'itemPrice': instance.itemPrice,
      'isItemDelivered': instance.isItemDelivered,
      'deductible': instance.deductible,
      'itemQuantity': instance.itemQuantity,
    };
