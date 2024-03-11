import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';

class AdminModel extends UserModel {
  const AdminModel({
    required super.name,
    required super.email,
    required super.password,
    required super.address,
    required super.balance,
    required super.dealingsId,
    required super.lastSeen,
    required super.type,
    required super.phone,
    required super.token,
    required super.notifications,
    super.id,
  });

  factory AdminModel.fromMap(DataMap map) {
    return AdminModel(
      id: map['_id'] as String ?? '',
      name: map['name'] as String ?? '',
      email: map['email'] as String ?? '',
      password: map['password'] as String ?? '',
      phone: (map['phone'] as List).cast<String>() ?? [],
      address: map['address'] as String ?? '',
      balance: map['balance'] as double ?? 0.0,
      dealingsId: (map['dealingsId'] as List).cast<String>() ?? [],
      type: map['type'] as String ?? '',
      token: map['token'] as String ?? '',
      notifications: (map['notifications'] as List).cast<String>() ?? [],
      lastSeen: map['lastSeen'] as String ?? '',
    );
  }


  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password':password,
      'phone': phone,
      'address': address,
      'balance': balance,
      'dealingsId': dealingsId,
      'about': about,
      'type': type,
      'token': token,
      'profilePic': profilePic,
      'notifications': notifications,
      'customers': customers,
      'lastSeen': lastSeen,
      'products': products,
      'badge': badge,
      'bannerImage': bannerImage,
      'cartIds': cartIds,
    };
  }

  @override
  List<Object?> get props => [email];
}
