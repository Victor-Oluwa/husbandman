// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersEntity _$AllOrdersEntityFromJson(Map<String, dynamic> json) =>
    AllOrdersEntity(
      grossTotal: (json['grossTotal'] as num).toDouble(),
      totalPercentage: (json['totalPercentage'] as num).toDouble(),
      orderName: json['orderName'] as String,
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((e) => OrderItemsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$AllOrdersEntityToJson(AllOrdersEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'grossTotal': instance.grossTotal,
      'orderName': instance.orderName,
      'totalPercentage': instance.totalPercentage,
      'orderItems': instance.orderItems.map((e) => e.toJson()).toList(),
    };
