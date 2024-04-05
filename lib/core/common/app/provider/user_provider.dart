import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/user/admin_model.dart';
import 'package:husbandman/core/common/app/models/user/buyer_model.dart';
import 'package:husbandman/core/common/app/models/user/farmer_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

final farmerProvider = StateNotifierProvider<FarmerNotifier, FarmerModel>(
  (ref) => FarmerNotifier(),
);
final buyerProvider = StateNotifierProvider<BuyerNotifier, BuyerModel>(
  (ref) => BuyerNotifier(),
);
final adminProvider = StateNotifierProvider<AdminNotifier, AdminModel>(
  (ref) => AdminNotifier(),
);

class FarmerNotifier extends StateNotifier<FarmerModel> {
  FarmerNotifier()
      : super(
          const FarmerModel(
            name: '',
            email: '',
            password: '',
            address: '',
            balance: 0,
            dealingsId: [],
            lastSeen: '',
            type: '',
            phone: [],
            token: 'Farmer',
            notifications: [],
          ),
        );

  void updateFarmerFromMap({required DataMap map}) {
    state = FarmerModel.fromMap(map);
  }

  FarmerModel updateFarmerFromModel( FarmerModel farmer) {
    return state = farmer;

  }
}

class BuyerNotifier extends StateNotifier<BuyerModel> {
  BuyerNotifier()
      : super(
          const BuyerModel(
            name: '',
            email: '',
            password: '',
            address: '',
            balance: 0,
            dealingsId: [],
            lastSeen: '',
            type: 'Buyer',
            phone: [],
            token: '',
            notifications: [],
          ),
        );

  void updateBuyerFromMap({required DataMap map}) {
    state = BuyerModel.fromMap(map);
  }

  BuyerModel updateBuyerFromModel( BuyerModel buyer) {
    return state = buyer;
  }
}

class AdminNotifier extends StateNotifier<AdminModel> {
  AdminNotifier()
      : super(
          const AdminModel(
            name: '',
            email: '',
            password: '',
            address: '',
            balance: 0,
            dealingsId: [],
            lastSeen: '',
            type: 'Admin',
            phone: [],
            token: '',
            notifications: [],
          ),
        );

  void updateAdminFromMap({required DataMap map}) {
    state = AdminModel.fromMap(map);
  }

  AdminModel updateAdminFromModel( AdminModel farmer) {
    return state = farmer;

  }
}
