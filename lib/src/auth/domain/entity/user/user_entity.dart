import 'package:equatable/equatable.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/address/address_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/customer/customer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/notification/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntity extends Equatable {
  const UserEntity({
    this.id = '',
    required this.userType,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
    this.profilePicture = '',
    this.lastSeen = '',
    this.phone = const [],
    this.address = const AddressEntity.empty(),
    this.dateJoined =  'Date mot set',
    this.balance = 0,
    this.pendingFunds = 0,
    this.totalWithdrawal = 0,
    this.orderHistoryId = 'Optional',
    this.withdrawHistoryId = 'Optional',
    this.fundingHistoryIds = const['Optional'],
    this.about = 'Optional',
    this.notification = const NotificationEntity.empty(),
    this.customer = const CustomerEntity.empty(),
    this.bannerImage = 'Optional',
    this.cartId = 'Optional',
    this.orderId = 'Optional',
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String userType;
  final String name;
  final String email;
  final String password;
  final List<String> phone;
  final AddressEntity address;
  final String dateJoined;
  final double balance;
  final double pendingFunds;
  final double totalWithdrawal;
  final String orderHistoryId;
  final String withdrawHistoryId;
  final List<String> fundingHistoryIds;
  final String about;
  final String token;
  final String profilePicture;
  final NotificationEntity notification;
  final CustomerEntity customer;
  final String lastSeen;
  final String bannerImage;
  final String cartId;
  final String orderId;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        address,
        balance,
        about,
      ];

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

//Total deposit
// pending funds
//pending order
