import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/customer/customer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/notification/notification_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buyer_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class BuyerEntity extends UserEntity {
  const BuyerEntity({
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
    required super.token,
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
    super.profilePicture,
    super.notification,
    super.customer,
    super.lastSeen,
    super.bannerImage,
    super.cartId,
    super.orderId,
  });

  BuyerEntity.empty()
      : super(
          id: '',
          userType: '',
          name: '',
          email: '',
          password: '',
          phone: [],
          address: const AddressEntity.empty(),
          dateJoined: '',
          balance: 0,
          pendingFunds: 0,
          totalWithdrawal: 0,
          orderHistoryId: '',
          withdrawHistoryId: '',
          fundingHistoryIds: [''],
          about: '',
          token: '',
          profilePicture: '',
          notification: const NotificationEntity.empty(),
          customer: const CustomerEntity.empty(),
          lastSeen: '',
          bannerImage: '',
          cartId: '',
          orderId: '',
        );

  factory BuyerEntity.fromJson(Map<String, dynamic> json) =>
      _$BuyerEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BuyerEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PendingPaymentEntity extends Equatable {
  const PendingPaymentEntity({
    this.id = '',
    required this.payments,
  });

  @JsonKey(name: '_id')
  final String id;
  final List<PaymentEntity> payments;

  @override
  List<Object?> get props => [id, payments];

  factory PendingPaymentEntity.fromJson(DataMap json)=> _$PendingPaymentEntityFromJson(json);
  DataMap toJson()=> _$PendingPaymentEntityToJson(this);
}

@JsonSerializable()
class PaymentEntity extends Equatable {
  const PaymentEntity({
    this.id= '',
    required this.sellerId,
    required this.orderId,
    required this.productId,
    required this.sellerName,
    required this.timeStamp,
    required this.productName,
    required this.productPrice,
  });

  @JsonKey(name: '_id')
  final String id;
  final String sellerId;
  final String orderId;
  final String productId;
  final String sellerName;
  final String timeStamp;
  final String productName;
  final String productPrice;

  @override
  List<Object?> get props => [
        id,
        sellerId,
        orderId,
        productId,
        productName,
        sellerName,
        timeStamp,
        productPrice,
      ];

  factory PaymentEntity.fromJson(DataMap json)=> _$PaymentEntityFromJson(json);
  DataMap toJson()=> _$PaymentEntityToJson(this);
}
