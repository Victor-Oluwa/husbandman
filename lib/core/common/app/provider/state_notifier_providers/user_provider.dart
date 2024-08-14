import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/admin/admin_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/buyer/buyer_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/user_entity.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserEntity>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<UserEntity> {
  UserNotifier()
      : super(
           const UserEntity(
            userType: '',
            name: '',
            email: '',
            password: '',
            token: '',
          ),
        );

  DataMap updateUserFromMap({required DataMap map}) {
    final userType = map['userType'];
    log('User map from provider: $map');
    switch (userType) {
      case 'Buyer':
        state = BuyerEntity.fromJson(map);
        return state.toJson();
      case 'Seller':
        state = SellerEntity.fromJson(map);
        return state.toJson();
      case 'Admin':
        state = AdminEntity.fromJson(map);
        return state.toJson();
      default:
        throw const AuthException(
          message: 'Failed to set user: Invalid User type',
          statusCode: 500,
        );
    }
  }

  UserEntity updateUserFromModel(UserEntity user) {
    return state = user;
  }
}
