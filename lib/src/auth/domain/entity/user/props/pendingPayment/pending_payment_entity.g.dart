// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_payment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingPaymentEntity _$PendingPaymentEntityFromJson(
        Map<String, dynamic> json) =>
    PendingPaymentEntity(
      payments: (json['payments'] as List<dynamic>)
          .map((e) => PaymentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$PendingPaymentEntityToJson(
        PendingPaymentEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };

PaymentEntity _$PaymentEntityFromJson(Map<String, dynamic> json) =>
    PaymentEntity(
      sellerId: json['sellerId'] as String,
      orderId: json['orderId'] as String,
      productId: json['productId'] as String,
      sellerName: json['sellerName'] as String,
      timeStamp: json['timeStamp'] as String,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$PaymentEntityToJson(PaymentEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sellerId': instance.sellerId,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'sellerName': instance.sellerName,
      'timeStamp': instance.timeStamp,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
    };
