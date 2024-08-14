import 'package:husbandman/src/auth/domain/entity/user/props/customer/customer_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.id,
    required super.ownerId,
    required List<ChildCustomerModel> super.childCustomer,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  static const empty = CustomerModel(
    id: '',
    ownerId: '',
    childCustomer: [],
  );

  @override
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class ChildCustomerModel extends ChildCustomerEntity {
  ChildCustomerModel({
    required super.id,
    required super.customerId,
    required super.customerName,
    required super.customerImage,
    required super.customerEmail,
    required super.customerPhone,
  });

  factory ChildCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$ChildCustomerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChildCustomerModelToJson(this);
}
