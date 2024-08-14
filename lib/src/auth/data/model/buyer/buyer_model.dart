import 'package:husbandman/src/auth/data/model/props/address/address_model.dart';
import 'package:husbandman/src/auth/data/model/props/customer/customer_model.dart';
import 'package:husbandman/src/auth/data/model/props/notification/notification_model.dart';
import 'package:husbandman/src/auth/data/model/props/pendingPayment/pending_payment_model.dart';
import 'package:husbandman/src/auth/domain/entity/user/buyer/buyer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/customer/customer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/notification/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buyer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BuyerModel extends BuyerEntity {
  const BuyerModel({
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
    required super.token,
    super.id,
    super.phone,
    super.dateJoined,
    super.balance,
    super.pendingFunds,
    super.totalWithdrawal,
    super.orderHistoryId,
    super.withdrawHistoryId,
    super.fundingHistoryIds,
    super.about,
    super.profilePicture,
    AddressModel super.address = AddressModel.empty,
    NotificationModel super.notification = NotificationModel.empty,
    CustomerModel super.customer = CustomerModel.empty,
    super.lastSeen,
    super.bannerImage,
    super.cartId,
    super.orderId,
    PendingPaymentModel super.pendingPayment = PendingPaymentModel.empty,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) =>
      _$BuyerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BuyerModelToJson(this);
}
