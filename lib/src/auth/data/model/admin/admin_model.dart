import 'package:husbandman/src/auth/domain/entity/user/admin/admin_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_model.g.dart';

@JsonSerializable()
class AdminModel extends AdminEntity {
  const AdminModel({
    required super.id,
    required super.userType,
    required super.name,
    required super.email,
    required super.password,
    required super.token,
    required super.profilePicture,
    required super.lastSeen,
  });

  factory AdminModel.fromJson(Map<String, dynamic>json)=> _$AdminModelFromJson(json);
  @override
  Map<String, dynamic> toJson()=> _$AdminModelToJson(this);
}
