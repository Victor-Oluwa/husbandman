// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingPaymentModel _$PendingPaymentModelFromJson(Map<String, dynamic> json) =>
    PendingPaymentModel(
      payments: (json['payments'] as List<dynamic>)
          .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$PendingPaymentModelToJson(
        PendingPaymentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      sellerId: json['sellerId'] as String,
      orderName: json['orderName'] as String,
      productId: json['productId'] as String,
      sellerName: json['sellerName'] as String,
      timeStamp: json['timeStamp'] as String,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sellerId': instance.sellerId,
      'orderName': instance.orderName,
      'productId': instance.productId,
      'sellerName': instance.sellerName,
      'timeStamp': instance.timeStamp,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
    };
