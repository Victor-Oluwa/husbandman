import 'package:husbandman/src/auth/data/model/props/address/address_model.dart';
import 'package:husbandman/src/auth/data/model/props/customer/customer_model.dart';
import 'package:husbandman/src/auth/data/model/props/notification/notification_model.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SellerModel extends SellerEntity {
  SellerModel({
    required super.id,
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
    required super.phone,
    required AddressModel super.address,
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
    required NotificationModel super.notification,
    required CustomerModel super.customer,
    required super.lastSeen,
    required super.bannerImage,
    required super.cartId,
    required super.orderId,
    super.ordered,
    super.pendingOrderFunds,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json)=> _$SellerModelFromJson(json);
  Map<String, dynamic> toJson()=> _$SellerModelToJson(this);
}
