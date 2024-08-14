import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/data/model/props/address/address_model.dart';
import 'package:husbandman/src/auth/data/model/props/customer/customer_model.dart';
import 'package:husbandman/src/auth/data/model/props/notification/notification_model.dart';
import 'package:husbandman/src/auth/data/model/props/pendingPayment/pending_payment_model.dart';
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
    required super.lastSeen,
    required super.bannerImage,
    required super.cartId,
    required super.orderId,
    NotificationModel super.notification = NotificationModel.empty,
    CustomerModel super.customer = CustomerModel.empty,
    AddressModel super.address = AddressModel.empty,
    OrderedModel super.ordered = OrderedModel.empty,
    PendingOrderFundsModel super.pendingOrderFunds =
        PendingOrderFundsModel.empty,
    PendingPaymentModel super.pendingPayment = PendingPaymentModel.empty,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) =>
      _$SellerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SellerModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PendingOrderFundsModel extends PendingOrderFundsEntity {
  const PendingOrderFundsModel({
    required super.funds,
    super.id,
  });

  factory PendingOrderFundsModel.fromJson(DataMap json) =>
      _$PendingOrderFundsModelFromJson(json);

  @override
  DataMap toJson() => _$PendingOrderFundsModelToJson(this);

  static const empty = PendingOrderFundsModel(
    funds: [],
  );

  @override
  List<dynamic> get props => [id, funds];
}

@JsonSerializable()
class FundModel extends FundEntity {
  const FundModel({
    required super.buyerId,
    required super.productId,
    required super.productName,
    required super.amountPending,
    super.id,
  });

  factory FundModel.fromJson(DataMap json) => _$FundModelFromJson(json);

  @override
  DataMap toJson() => _$FundModelToJson(this);

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

  static const empty = OrderedModel(
    totalEarning: 0,
    totalDeductible: 0,
    orderedItems: [],
  );

  @override
  List<Object?> get props => [id, totalEarning, totalDeductible, orderedItems];
}

@JsonSerializable()
class OrderedItemModel extends OrderedItemEntity {
  const OrderedItemModel({
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
