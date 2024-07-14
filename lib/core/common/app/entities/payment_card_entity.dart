class PaymentCardEntity {
  PaymentCardEntity({
    required this.id,
    required this.ownerId,
    required this.holderName,
    required this.number,
    required this.label,
    required this.type,
    required this.ccv,
    required this.expiryDate,
  });

  PaymentCardEntity.empty()
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

  factory PaymentCardEntity.fromMap(Map<String, dynamic> map) {
    return PaymentCardEntity(
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

  final String id;
  final String ownerId;
  final String holderName;
  final String number;
  final String label;
  final String type;
  final String ccv;
  final String expiryDate;

  Map<String, dynamic> toMap() {
    return {
      '_id':id,
      'ownerId': ownerId,
      'holderName': holderName,
      'number': number,
      'label': label,
      'type': type,
      'ccv': ccv,
      'expiryDate': expiryDate,
    };
  }

  PaymentCardEntity copyWith({
    String? id,
    String? ownerId,
    String? holderName,
    String? number,
    String? label,
    String? type,
    String? ccv,
    String? expiryDate,
  }) {
    return PaymentCardEntity(
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
