// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerEntity _$SellerEntityFromJson(Map<String, dynamic> json) => SellerEntity(
      userType: json['userType'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      id: json['_id'] as String? ?? '',
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      address: json['address'] == null
          ? const AddressEntity.empty()
          : AddressEntity.fromJson(json['address'] as Map<String, dynamic>),
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
      token: json['token'] as String? ?? '',
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
      pendingOrderFunds: json['pendingOrderFunds'] == null
          ? PendingOrderFundsEntity.empty
          : PendingOrderFundsEntity.fromJson(
              json['pendingOrderFunds'] as Map<String, dynamic>),
      ordered: json['ordered'] == null
          ? OrderedEntity.empty
          : OrderedEntity.fromJson(json['ordered'] as Map<String, dynamic>),
      pendingPayment: json['pendingPayment'] == null
          ? PendingPaymentEntity.empty
          : PendingPaymentEntity.fromJson(
              json['pendingPayment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerEntityToJson(SellerEntity instance) =>
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
      'ordered': instance.ordered.toJson(),
      'pendingOrderFunds': instance.pendingOrderFunds.toJson(),
    };

PendingOrderFundsEntity _$PendingOrderFundsEntityFromJson(
        Map<String, dynamic> json) =>
    PendingOrderFundsEntity(
      funds: (json['funds'] as List<dynamic>)
          .map((e) => FundEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$PendingOrderFundsEntityToJson(
        PendingOrderFundsEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'funds': instance.funds.map((e) => e.toJson()).toList(),
    };

FundEntity _$FundEntityFromJson(Map<String, dynamic> json) => FundEntity(
      buyerId: json['buyerId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      amountPending: (json['amountPending'] as num).toDouble(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$FundEntityToJson(FundEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'buyerId': instance.buyerId,
      'productId': instance.productId,
      'productName': instance.productName,
      'amountPending': instance.amountPending,
    };

OrderedEntity _$OrderedEntityFromJson(Map<String, dynamic> json) =>
    OrderedEntity(
      totalEarning: (json['totalEarning'] as num).toDouble(),
      totalDeductible: (json['totalDeductible'] as num).toDouble(),
      orderedItems: (json['orderedItems'] as List<dynamic>)
          .map((e) => OrderedItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$OrderedEntityToJson(OrderedEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalEarning': instance.totalEarning,
      'totalDeductible': instance.totalDeductible,
      'orderedItems': instance.orderedItems.map((e) => e.toJson()).toList(),
    };

OrderedItemEntity _$OrderedItemEntityFromJson(Map<String, dynamic> json) =>
    OrderedItemEntity(
      buyerId: json['buyerId'] as String,
      buyerName: json['buyerName'] as String,
      buyerImage: json['buyerImage'] as String,
      buyerEmail: json['buyerEmail'] as String,
      buyerAddress:
          AddressEntity.fromJson(json['buyerAddress'] as Map<String, dynamic>),
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: json['productPrice'] as String,
      deductible: json['deductible'] as String,
      productQuantity: json['productQuantity'] as String,
      productDeliveryDate: json['productDeliveryDate'] as String,
      isItemDelivered: json['isItemDelivered'] as bool,
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$OrderedItemEntityToJson(OrderedItemEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'buyerId': instance.buyerId,
      'buyerName': instance.buyerName,
      'buyerImage': instance.buyerImage,
      'buyerEmail': instance.buyerEmail,
      'buyerAddress': instance.buyerAddress,
      'productName': instance.productName,
      'productImage': instance.productImage,
      'productPrice': instance.productPrice,
      'deductible': instance.deductible,
      'productQuantity': instance.productQuantity,
      'productDeliveryDate': instance.productDeliveryDate,
      'isItemDelivered': instance.isItemDelivered,
    };
