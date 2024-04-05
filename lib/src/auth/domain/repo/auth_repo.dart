import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  ResultFuture<bool> authenticateResetPasswordToken({
    required String token,
  });

  ResultFuture<void> buyerSignUp({
    required String name,
    required String email,
    required String password,
    required String type,
    required String address,
  });

  ResultFuture<void> cacheUserToken({required String token});

  ResultFuture<void> cacheVerifiedInvitationToken({required String token});

  ResultFuture<void> farmerSignUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String type,
    required String invitationKey,
  });

  ResultFuture<void> resetPassword({required String newPassword});

  ResultFuture<String> retrieveUserToken();

  ResultFuture<void> setUser({required DataMap user});

  ResultFuture<void> sendResetPasswordToken({
    required String email,
  });

  ResultFuture<UserEntity> signIn({
    required String email,
    required String password,
  });

  ResultFuture<UserEntity> updateUser({
    required dynamic newData,
    required UpdateUserCulprit culprit,
  });

  ResultFuture<UserEntity> validateUser({required String token});

  ResultFuture<String> validateFarmerInvitationKey({
    required String invitationKey,
  });
}
