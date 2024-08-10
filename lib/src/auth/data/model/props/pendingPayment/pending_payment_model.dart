import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/pendingPayment/pending_payment_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pending_payment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PendingPaymentModel extends PendingPaymentEntity {
  const PendingPaymentModel({
    required List<PaymentModel> super.payments,
    super.id,
  });

  factory PendingPaymentModel.fromJson(DataMap json) =>
      _$PendingPaymentModelFromJson(json);

  DataMap toJson() => _$PendingPaymentModelToJson(this);

  @override
  List<Object?> get props => [id, payments];

}

@JsonSerializable()
class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.sellerId,
    required super.orderId,
    required super.productId,
    required super.sellerName,
    required super.timeStamp,
    required super.productName,
    required super.productPrice,
    super.id,
  });

  factory PaymentModel.fromJson(DataMap json) => _$PaymentModelFromJson(json);

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

  @override
  DataMap toJson() => _$PaymentModelToJson(this);
}
