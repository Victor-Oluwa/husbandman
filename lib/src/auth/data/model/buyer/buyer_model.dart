import 'package:husbandman/src/auth/domain/entity/user/buyer/buyer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/customer/customer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/notification/notification_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/pendingPayment/pending_payment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buyer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BuyerModel extends BuyerEntity {
  BuyerModel({
    super.id,
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
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
    required super.token,
    super.profilePicture,
    super.notification,
    super.customer,
    super.lastSeen,
    super.bannerImage,
    super.cartId,
    super.orderId,
    super.pendingPaymentEntity,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) =>
      _$BuyerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BuyerModelToJson(this);
}
