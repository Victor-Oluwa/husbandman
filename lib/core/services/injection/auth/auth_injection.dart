//AUTHENTICATION
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/services/injection/injection_container.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource_impl.dart';
import 'package:husbandman/src/auth/data/repo/auth_repo_impl.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/authenticate_reset_password_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/buyer_signup.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_user_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_verified_invitation_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/farmer_signup.dart';
import 'package:husbandman/src/auth/domain/use-cases/reset_password.dart';
import 'package:husbandman/src/auth/domain/use-cases/retrieve_user_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/send_reset_password_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/set_user.dart';
import 'package:husbandman/src/auth/domain/use-cases/sign_in.dart';
import 'package:husbandman/src/auth/domain/use-cases/sign_out.dart';
import 'package:husbandman/src/auth/domain/use-cases/update_user.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_farmer_invitation_key.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_user.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

final authBlocProvider = Provider<AuthBloc>((ref) {
  return AuthBloc(
    authenticateResetPasswordToken:
    ref.read(authenticateResetPasswordTokenProvider),
    signIn: ref.read(signInProvider),
    signOut: ref.read(signOutProvider),
    farmerSignUp: ref.read(farmerSignUpProvider),
    buyerSignUp: ref.read(buyerSignUpProvider),
    cacheUserToken: ref.read(cacheUserTokenProvider),
    cacheVerifiedInvitationToken:
    ref.read(cacheVerifiedInvitationTokenProvider),
    setUser: ref.read(setUserProvider),
    retrieveUserToken: ref.read(retrieveUserTokenProvider),
    validateUser: ref.read(validateUserProvider),
    validateFarmerInvitationKey: ref.read(validateFarmerInvitationKeyProvider),
    resetPassword: ref.read(resetPasswordProvider),
    sendResetPasswordToken: ref.read(sendResetPasswordTokenProvider),
    updateUser: ref.read(updateUserProvider),
  );
});

//Auth Dependencies
final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImpl(ref.read(authDatasourceProvider));
});

final authDatasourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSourceImpl(
    ref.read(httpClientProvider),
    ref.read(storageProvider),
    ref,
  );
});

//Auth Use-cases
final authenticateResetPasswordTokenProvider =
Provider<AuthenticateResetPasswordToken>((ref) {
  return AuthenticateResetPasswordToken(ref.read(authRepoProvider));
});

final signInProvider = Provider<SignIn>((ref) {
  return SignIn(ref.read(authRepoProvider));
});

final signOutProvider = Provider<SignOut>((ref){
  return SignOut(ref.read(authRepoProvider));
});

final farmerSignUpProvider = Provider<FarmerSignUp>((ref) {
  return FarmerSignUp(ref.read(authRepoProvider));
});

final buyerSignUpProvider = Provider<BuyerSignUp>((ref) {
  return BuyerSignUp(ref.read(authRepoProvider));
});

final cacheUserTokenProvider = Provider<CacheUserToken>((ref) {
  return CacheUserToken(ref.read(authRepoProvider));
});

final cacheVerifiedInvitationTokenProvider =
Provider<CacheVerifiedInvitationToken>((ref) {
  return CacheVerifiedInvitationToken(ref.read(authRepoProvider));
});

final setUserProvider = Provider<SetUser>((ref) {
  return SetUser(ref.read(authRepoProvider));
});

final retrieveUserTokenProvider = Provider<RetrieveUserToken>((ref) {
  return RetrieveUserToken(ref.read(authRepoProvider));
});

final validateUserProvider = Provider<ValidateUser>((ref) {
  return ValidateUser(ref.read(authRepoProvider));
});

final validateFarmerInvitationKeyProvider =
Provider<ValidateFarmerInvitationKey>((ref) {
  return ValidateFarmerInvitationKey(ref.read(authRepoProvider));
});

final resetPasswordProvider = Provider<ResetPassword>((ref) {
  return ResetPassword(ref.read(authRepoProvider));
});

final sendResetPasswordTokenProvider = Provider<SendResetPasswordToken>((ref) {
  return SendResetPasswordToken(ref.read(authRepoProvider));
});

final updateUserProvider = Provider<UpdateUser>((ref) {
  return UpdateUser(ref.read(authRepoProvider));
});
