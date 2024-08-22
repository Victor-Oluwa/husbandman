import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';

abstract class AuthRepo {
  ResultFuture<bool> authenticateResetPasswordToken({
    required String token,
  });

  ResultFuture<DataMap> signUp({
    required String name,
    required String email,
    required String password,
    required String type,
    required String address,
  });

  ResultFuture<void> cacheUserToken({required String token});

  ResultFuture<void> cacheVerifiedInvitationToken({required String token});

  ResultFuture<SellerEntity> farmerSignUp({
   required SellerEntity seller,
    required String invitationKey,
  });

  ResultFuture<void> resetPassword({required String newPassword});

  ResultFuture<String> retrieveUserToken();

  ResultFuture<DataMap> setUser({required DataMap user});

  ResultFuture<void> sendResetPasswordToken({
    required String email,
  });

  ResultFuture<DataMap> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signOut();

  ResultFuture<DataMap> updateUser({
    required String userId,
    required String userType,
    required dynamic newData,
    required UpdateUserCulprit culprit,
  });

  ResultFuture<DataMap> validateUser({required String token});

  ResultFuture<String> validateFarmerInvitationKey({
    required String invitationKey,
  });

  // ResultFuture<void> cacheInvitationKey({required String key});
}
