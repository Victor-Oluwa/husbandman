// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemsModel _$OrderItemsModelFromJson(Map<String, dynamic> json) =>
    OrderItemsModel(
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      itemImage: json['itemImage'] as String,
      itemDescription: json['itemDescription'] as String,
      itemPrice: (json['itemPrice'] as num).toDouble(),
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      itemDeliveryDate: json['itemDeliveryDate'] as String,
      isItemDelivered: json['isItemDelivered'] as bool,
      deductible: (json['deductible'] as num).toDouble(),
      itemQuantity: (json['itemQuantity'] as num).toInt(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$OrderItemsModelToJson(OrderItemsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
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
