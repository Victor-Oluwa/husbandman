import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

class FarmerModel extends UserModel {
  const FarmerModel({
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
    super.about,
    super.badge,
    super.bannerImage,
    super.customers,
    super.id,
    super.products,
    super.profilePic,
  });

  factory FarmerModel.fromMap(DataMap map) {
    return FarmerModel(
      id: map['_id'] as String ?? '',
      name: map['name'] as String ?? '',
      email: map['email'] as String ?? '',
      password: map['password'] as String ??'',
      phone: (map['phone'] as List).cast<String>() ?? [],
      address: map['address'] as String ?? '',
      balance: map['balance'] as double ?? 0.0,
      dealingsId: (map['dealingsId'] as List).cast<String>() ?? [],
      about: map['about'] as String ?? '',
      type: map['type'] as String ?? '',
      token: map['token'] as String ?? '',
      profilePic: map['profilePic'] as String ?? '',
      notifications: (map['notifications'] as List).cast<String>() ?? [],
      customers: (map['customers'] as List).cast<String>() ?? [],
      lastSeen: map['lastSeen'] as String ?? '',
      products: (map['products'] as List).cast<String>() ?? [],
      badge: map['badge'] as int ?? 0,
      bannerImage: map['bannerImage'] as String ?? '',
    );
  }

  FarmerModel.empty()
      : this(
          id: 'empty.value',
          name: 'empty.value',
          email: 'empty.value',
          password: 'empty.password',
          address: 'empty.value',
          balance: -1,
          dealingsId: ['dealingsId'],
          about: 'empty.value',
          profilePic: 'empty.value',
          customers: ['empty.value'],
          type: 'Farmer',
          phone: ['phone'],
          token: 'empty.token',
          notifications: ['notifications'],
          lastSeen: 'empty.laseSeen',
          products: ['empty.product'],
          badge: -1,
          bannerImage: 'bannerImage',
        );

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
  List<Object> get props => [
        name,
        email,
        address,
        balance,
        phone,
        dealingsId,
        lastSeen,
        type,
        token,
        badge,
        products,
      ];
}
