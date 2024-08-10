
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/data/model/buyer/buyer_model.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';
import 'package:husbandman/src/auth/domain/use-cases/signup.dart';

abstract class AuthDataSource {
  AuthDataSource();

  Future<bool> authenticateResetPasswordToken({
    required String token,
  });

  Future<DataMap> signUp({
    required String name,
    required String email,
    required String password,
    required String type,
    required String address,
  });

  Future<void> cacheUserToken({required String token});

  Future<void> cacheVerifiedInvitationToken({required String token});

  Future<SellerEntity> farmerSignUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String type,
    required String invitationKey,
  });

  Future<void> resetPassword({required String newPassword});

  Future<String> retrieveUserToken();

  Future<DataMap> setUser({required DataMap user});

  Future<void> sendResetPasswordToken({
    required String email,
  });

  Future<DataMap> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<DataMap> updateUser({
    required dynamic newData,
    required UpdateUserCulprit culprit,
  });

  Future<DataMap> validateUser({required String token});

  Future<String> validateFarmerInvitationKey({
    required String invitationKey,
  });

}

