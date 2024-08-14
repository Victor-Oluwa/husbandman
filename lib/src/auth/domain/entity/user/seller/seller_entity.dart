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
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
    super.id,
     super.phone,
     super.address,
     super.dateJoined,
     super.balance,
     super.pendingFunds,
     super.totalWithdrawal,
     super.orderHistoryId,
     super.withdrawHistoryId,
     super.fundingHistoryIds,
     super.about,
     super.token,
     super.profilePicture,
     super.notification,
     super.customer,
     super.lastSeen,
     super.bannerImage,
     super.cartId,
     super.orderId,
    this.pendingOrderFunds = PendingOrderFundsEntity.empty,
    this.ordered = OrderedEntity.empty,
    super.pendingPayment,
  });

  factory SellerEntity.fromJson(Map<String, dynamic> json) =>
      _$SellerEntityFromJson(json);

  final OrderedEntity ordered;
  final PendingOrderFundsEntity pendingOrderFunds;

  @override
  Map<String, dynamic> toJson() => _$SellerEntityToJson(this);

  static const empty = SellerEntity(
    id: '',
    userType: '',
    name: '',
    email: '',
    password: '',
    phone: [],
    address: AddressEntity.empty(),
    dateJoined: '',
    balance: 0,
    pendingFunds: 0,
    totalWithdrawal: 0,
    orderHistoryId: '',
    withdrawHistoryId: '',
    fundingHistoryIds: [],
    about: '',
    token: '',
    profilePicture: '',
    notification: NotificationEntity.empty(),
    customer: CustomerEntity.empty(),
    lastSeen: '',
    bannerImage: '',
    cartId: '',
    orderId: '',
  );

  @override
  List<Object?> get props => super.props + [ordered];
}

@JsonSerializable(explicitToJson: true)
class PendingOrderFundsEntity extends Equatable {
  const PendingOrderFundsEntity({
    required this.funds,
    this.id = '',
  });

  factory PendingOrderFundsEntity.fromJson(DataMap json) =>
      _$PendingOrderFundsEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final List<FundEntity> funds;

  DataMap toJson() => _$PendingOrderFundsEntityToJson(this);

  static const empty = PendingOrderFundsEntity(funds: []);

  @override
  List<dynamic> get props => [id, funds];
}

@JsonSerializable()
class FundEntity extends Equatable {
  const FundEntity({
    required this.buyerId,
    required this.productId,
    required this.productName,
    required this.amountPending,
    this.id = '',
  });

  factory FundEntity.fromJson(DataMap json) => _$FundEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String buyerId;
  final String productId;
  final String productName;
  final double amountPending;

  DataMap toJson() => _$FundEntityToJson(this);

  @override
  List<Object> get props => [
        id,
        buyerId,
        productId,
        productName,
        amountPending,
      ];
}

@JsonSerializable(explicitToJson: true)
class OrderedEntity extends Equatable {
  const OrderedEntity({
    required this.totalEarning,
    required this.totalDeductible,
    required this.orderedItems,
    this.id = '',
  });

  factory OrderedEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderedEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final double totalEarning;
  final double totalDeductible;
  final List<OrderedItemEntity> orderedItems;

  Map<String, dynamic> toJson() => _$OrderedEntityToJson(this);

  static const empty = OrderedEntity(
    totalEarning: 0,
    totalDeductible: 0,
    orderedItems: [],
  );

  @override
  List<Object?> get props => [id, totalEarning, totalDeductible, orderedItems];
}

@JsonSerializable()
class OrderedItemEntity extends Equatable {
  const OrderedItemEntity({
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
