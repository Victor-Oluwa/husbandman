import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/customer/customer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/notification/notification_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/pendingPayment/pending_payment_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class SellerEntity extends UserEntity {
  const SellerEntity({
    required super.id,
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
    required super.phone,
    required super.address,
    required super.dateJoined,
    required super.balance,
    required super.pendingFunds,
    required super.totalWithdrawal,
    required super.orderHistoryId,
    required super.withdrawHistoryId,
    required super.fundingHistoryIds,
    required super.about,
    required super.token,
    required super.profilePicture,
    required super.notification,
    required super.customer,
    required super.lastSeen,
    required super.bannerImage,
    required super.cartId,
    required super.orderId,
    this.pendingOrderFunds,
    this.ordered,
    super.pendingPaymentEntity,
  });

  factory SellerEntity.fromJson(Map<String, dynamic> json) =>
      _$SellerEntityFromJson(json);

  final OrderedEntity? ordered;
  final PendingOrderFundsEntity? pendingOrderFunds;

  @override
  Map<String, dynamic> toJson() => _$SellerEntityToJson(this);

  @override
  List<Object?> get props => super.props + [ordered];
}

@JsonSerializable(explicitToJson: true)
class PendingOrderFundsEntity extends Equatable {
  const PendingOrderFundsEntity({
    this.id = '',
    required this.funds,
  });

  @JsonKey(name: '_id')
  final String id;
  final List<FundEntity> funds;

  factory PendingOrderFundsEntity.fromJson(DataMap json) =>
      _$PendingOrderFundsEntityFromJson(json);

  DataMap toJson() => _$PendingOrderFundsEntityToJson(this);

  @override
  List<dynamic> get props => [id, funds];
}

@JsonSerializable()
class FundEntity extends Equatable {
  const FundEntity({
    this.id = '',
    required this.orderId,
    required this.buyerId,
    required this.productId,
    required this.productName,
    required this.amountPending,
  });

  @JsonKey(name: '_id')
  final String id;
  final String orderId;
  final String buyerId;
  final String productId;
  final String productName;
  final double amountPending;

  factory FundEntity.fromJson(DataMap json) => _$FundEntityFromJson(json);

  DataMap toJson() => _$FundEntityToJson(this);

  @override
  List<Object> get props => [
        id,
        orderId,
        buyerId,
        productId,
        productName,
        amountPending,
      ];
}

@JsonSerializable(explicitToJson: true)
class OrderedEntity extends Equatable {
  const OrderedEntity({
    this.id = '',
    required this.totalEarning,
    required this.totalDeductible,
    required this.orderedItems,
  });

  factory OrderedEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderedEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final double totalEarning;
  final double totalDeductible;
  final List<OrderedItemEntity> orderedItems;

  Map<String, dynamic> toJson() => _$OrderedEntityToJson(this);

  @override
  List<Object?> get props => [id, totalEarning, totalDeductible, orderedItems];
}

@JsonSerializable()
class OrderedItemEntity extends Equatable {
  const OrderedItemEntity({
    required this.sellerId,
    required this.buyerId,
    required this.buyerName,
    required this.buyerImage,
    required this.buyerEmail,
    required this.buyerAddress,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.deductible,
    required this.productQuantity,
    required this.productDeliveryDate,
    required this.isItemDelivered,
    this.id = '',
  });

  factory OrderedItemEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderedItemEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String sellerId;
  final String buyerId;
  final String buyerName;
  final String buyerImage;
  final String buyerEmail;
  final AddressEntity buyerAddress;
  final String productName;
  final String productImage;
  final String productPrice;
  final String deductible;
  final String productQuantity;
  final String productDeliveryDate;
  final bool isItemDelivered;

  Map<String, dynamic> toJson() => _$OrderedItemEntityToJson(this);

  @override
  List<Object?> get props => [
        sellerId,
        buyerId,
        buyerName,
        buyerImage,
        buyerEmail,
        buyerAddress,
        productName,
        productImage,
        productPrice,
        deductible,
        productQuantity,
        productDeliveryDate,
        isItemDelivered,
      ];
}
