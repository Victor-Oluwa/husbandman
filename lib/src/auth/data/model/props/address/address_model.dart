import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends AddressEntity {
  const AddressModel({
    required super.fullAddress,
    required super.city,
    required super.state,
    required super.country,
    required super.zipCode,
    super.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  static const empty = AddressModel(
    fullAddress: '',
    city: '',
    state: '',
    country: '',
    zipCode: '',
  );

  @override
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
