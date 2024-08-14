// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerModel _$SellerModelFromJson(Map<String, dynamic> json) => SellerModel(
      id: json['_id'] as String? ?? '',
      userType: json['userType'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
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
      token: json['token'] as String? ?? '',
      profilePicture: json['profilePicture'] as String? ?? '',
      lastSeen: json['lastSeen'] as String? ?? '',
      bannerImage: json['bannerImage'] as String? ?? 'Optional',
      cartId: json['cartId'] as String? ?? 'Optional',
      orderId: json['orderId'] as String? ?? 'Optional',
      notification: json['notification'] == null
          ? NotificationModel.empty
          : NotificationModel.fromJson(
              json['notification'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? CustomerModel.empty
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      address: json['address'] == null
          ? AddressModel.empty
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      ordered: json['ordered'] == null
          ? OrderedModel.empty
          : OrderedModel.fromJson(json['ordered'] as Map<String, dynamic>),
      pendingOrderFunds: json['pendingOrderFunds'] == null
          ? PendingOrderFundsModel.empty
          : PendingOrderFundsModel.fromJson(
              json['pendingOrderFunds'] as Map<String, dynamic>),
      pendingPayment: json['pendingPayment'] == null
          ? PendingPaymentModel.empty
          : PendingPaymentModel.fromJson(
              json['pendingPayment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerModelToJson(SellerModel instance) =>
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

PendingOrderFundsModel _$PendingOrderFundsModelFromJson(
        Map<String, dynamic> json) =>
    PendingOrderFundsModel(
      funds: (json['funds'] as List<dynamic>)
          .map((e) => FundEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$PendingOrderFundsModelToJson(
        PendingOrderFundsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'funds': instance.funds.map((e) => e.toJson()).toList(),
    };

FundModel _$FundModelFromJson(Map<String, dynamic> json) => FundModel(
      buyerId: json['buyerId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      amountPending: (json['amountPending'] as num).toDouble(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$FundModelToJson(FundModel instance) => <String, dynamic>{
      '_id': instance.id,
      'buyerId': instance.buyerId,
      'productId': instance.productId,
      'productName': instance.productName,
      'amountPending': instance.amountPending,
    };

OrderedModel _$OrderedModelFromJson(Map<String, dynamic> json) => OrderedModel(
      totalEarning: (json['totalEarning'] as num).toDouble(),
      totalDeductible: (json['totalDeductible'] as num).toDouble(),
      orderedItems: (json['orderedItems'] as List<dynamic>)
          .map((e) => OrderedItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$OrderedModelToJson(OrderedModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalEarning': instance.totalEarning,
      'totalDeductible': instance.totalDeductible,
      'orderedItems': instance.orderedItems.map((e) => e.toJson()).toList(),
    };

OrderedItemModel _$OrderedItemModelFromJson(Map<String, dynamic> json) =>
    OrderedItemModel(
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

Map<String, dynamic> _$OrderedItemModelToJson(OrderedItemModel instance) =>
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
