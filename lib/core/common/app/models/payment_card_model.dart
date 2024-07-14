import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/utils/typedef.dart';

class PaymentCardModel extends PaymentCardEntity {
  PaymentCardModel({
    required super.holderName,
    required super.number,
    required super.label,
    required super.type,
    required super.ccv,
    required super.expiryDate,
    required super.ownerId,
    required super.id,
  });

  PaymentCardModel.empty()
      : this(
          id: '',
          ownerId: '',
          ccv: '',
          expiryDate: '',
          holderName: '',
          label: '',
          number: '',
          type: '',
        );

  factory PaymentCardModel.fromMap(DataMap map) {
    return PaymentCardModel(
      id: map['_id'] as String,
      ownerId: map['ownerId'] as String,
      holderName: map['holderName'] as String,
      number: map['number'] as String,
      label: map['label'] as String,
      type: map['type'] as String,
      ccv: map['ccv'] as String,
      expiryDate: map['expiryDate'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'ownerId': ownerId,
      'holderName': holderName,
      'number': number,
      'label': label,
      'type': type,
      'ccv': ccv,
      'expiryDate': expiryDate,
    };
  }

  @override
  PaymentCardModel copyWith({
    String? id,
    String? ownerId,
    String? holderName,
    String? number,
    String? label,
    String? type,
    String? ccv,
    String? expiryDate,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      holderName: holderName ?? this.holderName,
      number: number ?? this.number,
      label: label ?? this.label,
      type: type ?? this.type,
      ccv: ccv ?? this.ccv,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}
