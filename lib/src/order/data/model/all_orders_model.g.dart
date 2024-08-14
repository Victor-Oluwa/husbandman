// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersModel _$AllOrdersModelFromJson(Map<String, dynamic> json) =>
    AllOrdersModel(
      grossTotal: (json['grossTotal'] as num).toDouble(),
      orderName: json['orderName'] as String,
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((e) => OrderItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPercentage: (json['totalPercentage'] as num).toDouble(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$AllOrdersModelToJson(AllOrdersModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'grossTotal': instance.grossTotal,
      'orderName': instance.orderName,
      'totalPercentage': instance.totalPercentage,
      'orderItems': instance.orderItems.map((e) => e.toJson()).toList(),
    };
