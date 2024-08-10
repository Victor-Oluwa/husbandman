
import 'package:json_annotation/json_annotation.dart';

part 'customer_entity.g.dart';
@JsonSerializable(explicitToJson: true)
class CustomerEntity {
  CustomerEntity({
    required this.id,
    required this.ownerId,
    required this.childCustomer,
  });

  factory CustomerEntity.fromJson(Map<String, dynamic> json) =>
      _$CustomerEntityFromJson(json);

 const CustomerEntity.empty()
      : id = '',
        ownerId = '',
        childCustomer = const [];

  @JsonKey(name: '_id')
  final String id;
  final String ownerId;
  final List<ChildCustomerEntity> childCustomer;

  Map<String, dynamic> toJson() => _$CustomerEntityToJson(this);
}

@JsonSerializable()
class ChildCustomerEntity {
  ChildCustomerEntity({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerImage,
    required this.customerEmail,
    required this.customerPhone,
  });

  ChildCustomerEntity.empty()
      : id = '',
        customerId = '',
        customerName = '',
        customerImage = '',
        customerEmail = '',
        customerPhone = [];

  factory ChildCustomerEntity.fromJson(Map<String, dynamic> json) =>
      _$ChildCustomerEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String customerId;
  final String customerName;
  final String customerImage;
  final String customerEmail;
  final List<String> customerPhone;

  Map<String, dynamic> toJson() => _$ChildCustomerEntityToJson(this);
}