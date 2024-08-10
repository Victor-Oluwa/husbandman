
import 'package:json_annotation/json_annotation.dart';

part 'address_entity.g.dart';
@JsonSerializable()
class AddressEntity {
  AddressEntity({
    required this.id,
    required this.fullAddress,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

 const AddressEntity.empty()
      : id = '',
        fullAddress = '',
        city = '',
        state = '',
        country = '',
        zipCode = '';

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
  @JsonKey(name: '_id')
  final String id;
  final String fullAddress;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);
}
