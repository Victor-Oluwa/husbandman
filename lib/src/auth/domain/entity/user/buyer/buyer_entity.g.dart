// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyerEntity _$BuyerEntityFromJson(Map<String, dynamic> json) => BuyerEntity(
      userType: json['userType'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
      id: json['_id'] as String? ?? '',
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      address: json['address'] == null
          ? const AddressEntity.empty()
          : AddressEntity.fromJson(json['address'] as Map<String, dynamic>),
      dateJoined: json['dateJoined'] as String? ?? 'Date mot set',
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      pendingFunds: (json['pendingFunds'] as num?)?.toDouble() ?? 0,
      totalWithdrawal: (json['totalWithdrawal'] as num?)?.toDouble() ?? 0,
      orderHistoryId: json['orderHistoryId'] as String? ?? 'Optional',
      withdrawHistoryId: json['withdrawHistoryId'] as String? ?? 'Optional',
      fundingHistoryIds: (json['fundingHistoryIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['Optional'],
      about: json['about'] as String? ?? 'Optional',
      profilePicture: json['profilePicture'] as String? ?? '',
      notification: json['notification'] == null
          ? const NotificationEntity.empty()
          : NotificationEntity.fromJson(
              json['notification'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? const CustomerEntity.empty()
          : CustomerEntity.fromJson(json['customer'] as Map<String, dynamic>),
      lastSeen: json['lastSeen'] as String? ?? '',
      bannerImage: json['bannerImage'] as String? ?? 'Optional',
      cartId: json['cartId'] as String? ?? 'Optional',
      orderId: json['orderId'] as String? ?? 'Optional',
    );

Map<String, dynamic> _$BuyerEntityToJson(BuyerEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userType': instance.userType,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'address': instance.address.toJson(),
      'dateJoined': instance.dateJoined,
      'balance': instance.balance,
      'pendingFunds': instance.pendingFunds,
      'totalWithdrawal': instance.totalWithdrawal,
      'orderHistoryId': instance.orderHistoryId,
      'withdrawHistoryId': instance.withdrawHistoryId,
      'fundingHistoryIds': instance.fundingHistoryIds,
      'about': instance.about,
      'token': instance.token,
      'profilePicture': instance.profilePicture,
      'notification': instance.notification.toJson(),
      'customer': instance.customer.toJson(),
      'lastSeen': instance.lastSeen,
      'bannerImage': instance.bannerImage,
      'cartId': instance.cartId,
      'orderId': instance.orderId,
    };

PendingPaymentEntity _$PendingPaymentEntityFromJson(
        Map<String, dynamic> json) =>
    PendingPaymentEntity(
      id: json['_id'] as String? ?? '',
      payments: (json['payments'] as List<dynamic>)
          .map((e) => PaymentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PendingPaymentEntityToJson(
        PendingPaymentEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };

PaymentEntity _$PaymentEntityFromJson(Map<String, dynamic> json) =>
    PaymentEntity(
      id: json['_id'] as String? ?? '',
      sellerId: json['sellerId'] as String,
      orderId: json['orderId'] as String,
      productId: json['productId'] as String,
      sellerName: json['sellerName'] as String,
      timeStamp: json['timeStamp'] as String,
      productName: json['productName'] as String,
      productPrice: json['productPrice'] as String,
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
