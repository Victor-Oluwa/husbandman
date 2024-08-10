// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['_id'] as String,
      fullAddress: json['fullAddress'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullAddress': instance.fullAddress,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zipCode': instance.zipCode,
    };
