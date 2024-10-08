// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyerModel _$BuyerModelFromJson(Map<String, dynamic> json) => BuyerModel(
      userType: json['userType'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      token: json['token'] as String? ?? '',
      id: json['_id'] as String? ?? '',
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      dateJoined: json['dateJoined'] as String? ?? 'Date not set',
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
      address: json['address'] == null
          ? AddressModel.empty
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      notification: json['notification'] == null
          ? NotificationModel.empty
          : NotificationModel.fromJson(
              json['notification'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? CustomerModel.empty
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      lastSeen: json['lastSeen'] as String? ?? '',
      bannerImage: json['bannerImage'] as String? ?? 'Optional',
      cartId: json['cartId'] as String? ?? 'Optional',
      orderId: json['orderId'] as String? ?? 'Optional',
      pendingPayment: json['pendingPayment'] == null
          ? PendingPaymentModel.empty
          : PendingPaymentModel.fromJson(
              json['pendingPayment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuyerModelToJson(BuyerModel instance) =>
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
      'pendingPayment': instance.pendingPayment.toJson(),
    };
