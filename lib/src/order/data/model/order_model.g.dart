// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      ownerId: json['ownerId'] as String,
      grandTotal: (json['grandTotal'] as num).toDouble(),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => AllOrdersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'grandTotal': instance.grandTotal,
      'orders': instance.orders.map((e) => e.toJson()).toList(),
    };
