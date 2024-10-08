import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending_payment_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class PendingPaymentEntity extends Equatable {
  const PendingPaymentEntity({
    required this.payments,
    this.id = '',
  });

  factory PendingPaymentEntity.fromJson(DataMap json) =>
      _$PendingPaymentEntityFromJson(json);

   static const empty = PendingPaymentEntity(
     payments: [PaymentEntity.empty()],
   );

  @JsonKey(name: '_id')
  final String id;
  final List<PaymentEntity> payments;

  @override
  List<Object?> get props => [id, payments];

  DataMap toJson() => _$PendingPaymentEntityToJson(this);
}

@JsonSerializable()
class PaymentEntity extends Equatable {
  const PaymentEntity({
    required this.sellerId,
    required this.orderName,
    required this.productId,
    required this.sellerName,
    required this.timeStamp,
    required this.productName,
    required this.productPrice,
    this.id = '',
  });

  factory PaymentEntity.fromJson(DataMap json) => _$PaymentEntityFromJson(json);

  const PaymentEntity.empty():this(
    orderName: '',
    productId: '',
    productName: '',
    productPrice: 0,
    sellerId: '',
    sellerName: '',
    timeStamp: '',
    id: '',
  );

  @JsonKey(name: '_id')
  final String id;
  final String sellerId;
  final String orderName;
  final String productId;
  final String sellerName;
  final String timeStamp;
  final String productName;
  final double productPrice;

  @override
  List<Object?> get props => [
        id,
        sellerId,
        orderName,
        productId,
        productName,
        sellerName,
        timeStamp,
        productPrice,
      ];

  DataMap toJson() => _$PaymentEntityToJson(this);
}
