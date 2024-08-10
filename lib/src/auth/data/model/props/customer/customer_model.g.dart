// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: json['_id'] as String,
      ownerId: json['ownerId'] as String,
      childCustomer: (json['childCustomer'] as List<dynamic>)
          .map((e) => ChildCustomerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'childCustomer': instance.childCustomer.map((e) => e.toJson()).toList(),
    };

ChildCustomerModel _$ChildCustomerModelFromJson(Map<String, dynamic> json) =>
    ChildCustomerModel(
      id: json['_id'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      customerImage: json['customerImage'] as String,
      customerEmail: json['customerEmail'] as String,
      customerPhone: (json['customerPhone'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChildCustomerModelToJson(ChildCustomerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerImage': instance.customerImage,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
    };
