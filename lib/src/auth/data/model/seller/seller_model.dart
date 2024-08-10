import 'package:husbandman/src/auth/data/model/props/address/address_model.dart';
import 'package:husbandman/src/auth/data/model/props/customer/customer_model.dart';
import 'package:husbandman/src/auth/data/model/props/notification/notification_model.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SellerModel extends SellerEntity {
  const SellerModel({
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

  factory SellerModel.fromJson(Map<String, dynamic> json) =>
      _$SellerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderedModel extends OrderedEntity {
  const OrderedModel({
    required super.totalEarning,
    required super.totalDeductible,
    required super.orderedItems,
    super.id,
  });

  factory OrderedModel.fromJson(Map<String, dynamic> json) =>
      _$OrderedModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderedModelToJson(this);

  @override
  List<Object?> get props => [id, totalEarning, totalDeductible, orderedItems];
}

@JsonSerializable()
class OrderedItemModel extends OrderedItemEntity {
  const OrderedItemModel({
    required super.sellerId,
    required super.buyerId,
    required super.buyerName,
    required super.buyerImage,
    required super.buyerEmail,
    required super.buyerAddress,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.deductible,
    required super.productQuantity,
    required super.productDeliveryDate,
    required super.isItemDelivered,
    super.id,
  });

  factory OrderedItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderedItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderedItemModelToJson(this);

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
