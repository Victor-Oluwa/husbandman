import 'dart:developer';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.balance,
    required this.dealingsId,
    required this.lastSeen,
    required this.token,
    required this.notifications,
    required this.type,
    required this.phone,
    this.id = '',
    this.about = '',
    this.profilePic = '',
    this.customers = const <String>[],
    this.products = const <String>[],
    this.badge = 1,
    this.bannerImage = '',
    this.cartIds = const <String>[],
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as List<String>,
      address: map['address'] as String,
      balance: map['balance'] as double,
      dealingsId: map['dealingsId'] as List<String>,
      about: map['about'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
      profilePic: map['profilePic'] as String,
      notifications: map['notifications'] as List<String>,
      customers: map['customers'] as List<String>,
      lastSeen: map['lastSeen'] as String,
      products: map['products'] as List<String>,
      badge: map['badge'] as int,
      bannerImage: map['bannerImage'] as String,
      cartIds: map['cartIds'] as List<String>,
    );
  }

  UserEntity.empty()
      : this(
          id: 'empty.value',
          name: 'empty.value',
          email: 'empty.value',
          address: 'empty.value',
          password: 'empty.password',
          balance: 1,
          about: 'empty.value',
          dealingsId: [''],
          profilePic: 'empty.value',
          customers: ['empty.value'],
          type: 'empty.value',
          phone: [''],
          token: 'empty.token',
          notifications: [''],
          lastSeen: 'empty.laseSeen',
          products: ['empty.product'],
          badge: 1,
          bannerImage: '',
          cartIds: ['empty.cartIds'],
        );

  final String id;
  final String name;
  final String email;
  final String password;
  final List<String> phone;
  final String address;
  final double balance;
  final List<String> dealingsId;
  final String about;
  final String type;
  final String token;
  final String profilePic;
  final List<String> notifications;
  final List<String> customers;
  final String lastSeen;
  final List<String> products;
  final int badge;
  final String bannerImage;
  final List<String> cartIds;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        address,
        balance,
        about,
        profilePic,
        customers,
      ];

  Map<String, dynamic> toMap() {
    return {
      '_id': id?? '',
      'name': name??'',
      'email': email??'',
      'password': password??'',
      'phone': phone??'',
      'address': address??'',
      'balance': balance??0,
      'dealingsId': dealingsId??[''],
      'about': about??'',
      'type': type??'',
      'token': token??'',
      'profilePic': profilePic??'',
      'notifications': notifications??[''],
      'customers': customers??[''],
      'lastSeen': lastSeen??'',
      'products': products?? [''],
      'badge': badge??0,
      'bannerImage': bannerImage??'',
      'cartIds': cartIds?? [''],
    };
  }
}
