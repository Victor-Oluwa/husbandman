
import 'package:husbandman/core/common/app/models/user/user_model.dart';

class BuyerModel extends UserModel {
  const BuyerModel({
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
    super.cartIds,
    super.customers,
    super.id,
    super.profilePic,
  });

  BuyerModel.empty()
      : this(
          id: 'empty.value',
          name: 'empty.value',
          email: 'empty.value',
          password: 'empty.password',
          address: 'empty.value',
          balance: 1,
          dealingsId: ['phone'],
          profilePic: 'empty.value',
          customers: ['empty.value'],
          type: 'Buyer',
          phone: ['phone'],
          token: 'empty.token',
          notifications: ['phone'],
          lastSeen: 'empty.laseSeen',
        );

  factory BuyerModel.fromMap(Map<String, dynamic> map) {
    return BuyerModel(
      id: map['_id'] as String ?? '',
      name: map['name'] as String ?? '',
      email: map['email'] as String ?? '',
      password: map['password'] as String ?? '',
      phone: (map['phone'] as List).cast<String>() ?? [],
      address: map['address'] as String ?? '',
      balance: double.parse(map['balance'].toString()) ?? 0.0,
      dealingsId: (map['dealingsId'] as List).cast<String>() ?? [],
      type: map['type'] as String ?? '',
      token: map['token'] as String ?? '',
      profilePic: map['profilePic'].toString()??'',
      notifications: (map['notifications'] as List).cast<String>() ?? [],
      customers: (map['customers'] as List).cast<String>() ?? [],
      lastSeen: map['lastSeen'] as String ?? '',
      cartIds: (map['cartIds'] as List).cast<String>() ?? [],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
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
  List<Object> get props => [email];
}
