// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartEntity _$CartEntityFromJson(Map<String, dynamic> json) => CartEntity(
      ownerId: json['ownerId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$CartEntityToJson(CartEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
