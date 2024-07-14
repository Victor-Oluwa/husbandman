import 'dart:developer';

import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
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
    super.about,
    super.profilePic,
    super.customers,
    super.badge,
    super.bannerImage,
    super.cartIds,
    super.products,
  });

  // Convert Entity to Model
  // factory ProductModel.fromEntity(ProductEntity entity) {
  //   return ProductModel(id: entity.id, name: entity.name, price: entity.price);
  // }

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['_id'] as String ?? '',
      name: map['name'] as String ?? '',
      email: map['email'] as String ?? '',
      password: map['password'] as String ?? '',
      phone: (map['phone'] as List).cast<String>() ?? [],
      address: map['address'] as String ?? '',
      balance:  double.parse(map['balance'].toString()) ?? 0.0,
      dealingsId: (map['dealingsId'] as List).cast<String>() ?? [],
      type: map['type'] as String ?? '',
      token: map['token'] as String ?? '',
      profilePic: map['profilePic'] as String ?? '',
      notifications: (map['notifications'] as List).cast<String>() ?? [],
      customers: (map['customers'] as List).cast<String>() ?? [],
      lastSeen: map['lastSeen'] as String ?? '',
    );
  }

  UserModel.empty()
      : this(
          id: 'empty.value',
          name: 'empty.value',
          email: 'empty.value',
          password: 'empty.password',
          address: 'empty.value',
          balance: -1,
          dealingsId: [''],
          about: 'empty.value',
          profilePic: 'empty.value',
          customers: ['empty.value'],
          type: 'empty.value',
          phone: [''],
          token: 'empty.token',
          notifications: [''],
          lastSeen: 'empty.laseSeen',
          products: ['empty.product'],
          badge: -1,
          bannerImage: '',
          cartIds: ['empty.cartIds'],
        );

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
  List<Object?> get props => [name, email, address, type, id];
}



