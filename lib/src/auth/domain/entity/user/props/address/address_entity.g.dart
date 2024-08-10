// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressEntity _$AddressEntityFromJson(Map<String, dynamic> json) =>
    AddressEntity(
      id: json['_id'] as String,
      fullAddress: json['fullAddress'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
    );

Map<String, dynamic> _$AddressEntityToJson(AddressEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullAddress': instance.fullAddress,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zipCode': instance.zipCode,
    };
