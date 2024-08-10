import 'package:husbandman/src/auth/domain/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_entity.g.dart';

@JsonSerializable()
class AdminEntity extends UserEntity {
   AdminEntity({
    required super.id,
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
    required super.token,
    required super.profilePicture,
    required super.lastSeen,
  });

  @override
  List<dynamic> get props => super.props;

  factory AdminEntity.fromJson(Map<String, dynamic>json)=> _$AdminEntityFromJson(json);
  Map<String, dynamic> toJson()=> _$AdminEntityToJson(this);
}
