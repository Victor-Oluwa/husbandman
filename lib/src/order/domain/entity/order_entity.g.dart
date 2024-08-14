// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) => OrderEntity(
      ownerId: json['ownerId'] as String,
      grandTotal: (json['grandTotal'] as num).toDouble(),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => AllOrdersEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$OrderEntityToJson(OrderEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'grandTotal': instance.grandTotal,
      'orders': instance.orders.map((e) => e.toJson()).toList(),
    };
