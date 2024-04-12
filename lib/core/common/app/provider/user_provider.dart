import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/user/farmer_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
      (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(
          const UserModel(
            name: '',
            email: '',
            password: '',
            address: '',
            balance: 0,
            dealingsId: [],
            lastSeen: '',
            type: '',
            phone: [],
            token: '',
            notifications: [],
            badge: 0,
          ),
        );

  void updateUserFromMap({required DataMap map}) {
    state = FarmerModel.fromMap(map);
  }

  FarmerModel updateUserFromModel( FarmerModel farmer) {
    return state = farmer;

  }
}
