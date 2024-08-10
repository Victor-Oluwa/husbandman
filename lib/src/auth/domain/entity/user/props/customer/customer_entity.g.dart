// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerEntity _$CustomerEntityFromJson(Map<String, dynamic> json) =>
    CustomerEntity(
      id: json['_id'] as String,
      ownerId: json['ownerId'] as String,
      childCustomer: (json['childCustomer'] as List<dynamic>)
          .map((e) => ChildCustomerEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerEntityToJson(CustomerEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'childCustomer': instance.childCustomer.map((e) => e.toJson()).toList(),
    };

ChildCustomerEntity _$ChildCustomerEntityFromJson(Map<String, dynamic> json) =>
    ChildCustomerEntity(
      id: json['_id'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      customerImage: json['customerImage'] as String,
      customerEmail: json['customerEmail'] as String,
      customerPhone: (json['customerPhone'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChildCustomerEntityToJson(
        ChildCustomerEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerImage': instance.customerImage,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
    };
