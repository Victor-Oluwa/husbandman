// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminEntity _$AdminEntityFromJson(Map<String, dynamic> json) => AdminEntity(
      id: json['_id'] as String? ?? '',
      userType: json['userType'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      token: json['token'] as String? ?? '',
      profilePicture: json['profilePicture'] as String? ?? '',
      lastSeen: json['lastSeen'] as String? ?? '',
    );

Map<String, dynamic> _$AdminEntityToJson(AdminEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userType': instance.userType,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
      'profilePicture': instance.profilePicture,
      'lastSeen': instance.lastSeen,
    };
