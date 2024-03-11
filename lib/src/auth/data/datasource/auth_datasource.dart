
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';

abstract class AuthDataSource {
  AuthDataSource();

  Future<bool> authenticateResetPasswordToken({
    required String token,
  });

  Future<void> buyerSignUp({
    required String name,
    required String email,
    required String password,
    required String type,
    required String address,
  });

  Future<void> cacheUserToken({required String token});

  Future<void> farmerSignUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String type,
    required String invitationKey,
  });

  Future<void> resetPassword({required String newPassword});

  Future<String> retrieveUserToken();

  Future<void> setUser({required DataMap user});

  Future<void> sendResetPasswordToken({
    required String email,
  });

  Future<UserEntity> signIn({
    required String email,
    required String password,
  });

  Future<UserEntity> updateUser({
    required dynamic newData,
    required UpdateUserCulprit culprit,
  });

  Future<UserEntity> validateUser({required String token});

  Future<String> validateFarmerInvitationKey({
    required String invitationKey,
  });

}

